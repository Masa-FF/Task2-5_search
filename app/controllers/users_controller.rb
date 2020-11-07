class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  before_action :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    @books = Book.all
  end  

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
       redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  def search
    @user_or_book = params[:option]
    if @user_or_book == "1"
      @users = User.search(params[:search], @user_or_book)
    else
      @books = Book.search(params[:search], @user_or_book)
    end
  end
  
  def User.search(search, user_or_book)
      if user_or_book == "1"
         User.where(['name LIKE ?', "%#{search}%"])
      else
         User.all
      end
  end
  
  def Book.search(search, user_or_book)
    if user_or_book == "2"
       Book.where(['title LIKE ?', "%#{search}%"])
    else
       Book.all
    end
  end
  

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
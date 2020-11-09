Rails.application.routes.draw do
  get 'search/search'
  devise_for :users
  resources :users, only: [:index, :show, :create, :edit, :update]
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
  
  resources :relationships, only: [:create, :destroy]
  
  root 'homes#top'
  get 'home/about' => 'homes#about'
  get 'search' => 'search#search'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
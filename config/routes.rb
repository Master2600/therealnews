Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  get 'home/index'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  resources :news do
    member do
      post 'create_comment'
    end
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  
  
  resources :users, only: [:index, :destroy] if User.new.respond_to?(:role)
end
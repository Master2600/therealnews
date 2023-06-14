Rails.application.routes.draw do
  root "home#index"
  get 'home/index'

  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'}

  resources :news do
    post 'create_comment', to: 'news#create_comment'
    

    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  
    resources :users, only: [:index, :destroy, :create] if User.new.respond_to?(:role)
end




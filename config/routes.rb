Rails.application.routes.draw do
  root to: 'pages#index'
  resources :pages, only: :show
  resources :posts, only: [:new, :show, :create, :destroy]
  resources :likes, only: :create
  namespace :api, format: 'json' do
    resources :books, only: [:index, :create, :destroy,:update]
  end
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  resources :booklist, only: [:index]
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  root to: 'pages#index'
  resources :pages, only: :show
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

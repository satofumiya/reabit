Rails.application.routes.draw do
  root to: 'pages#index'
  namespace :api, format: 'json' do
    resources :books, only: [:index, :create, :destroy,:update]
  end
  resources :booklist, only: [:index]
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

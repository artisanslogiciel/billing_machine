Backbone::Application.routes.draw do
  devise_for :users
  root to: 'static_pages#index'
  resources :projects, only: [:index]
  resources :time_slices, only: [:index]
  resources :invoices, only: [:index, :show]

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :projects, only: [:index, :create, :update]
      resources :invoices, only: [:index, :create, :update, :show]
      resources :time_slices, only: [:index, :create, :update]
      resources :activities, only: [:index]
      resources :payment_terms, only: [:index]
      resources :customers, only: [:index]
    end
  end
end

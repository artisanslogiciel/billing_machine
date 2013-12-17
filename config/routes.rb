Backbone::Application.routes.draw do
  resources :projects, only: [:index]
  resources :time_slices, only: [:index]

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :projects, only: [:show, :index, :create, :update]
      resources :activities, only: [:index]
      resources :time_slices, only: [:index, :create, :update]
    end
  end
end

Backbone::Application.routes.draw do
  resources :projects, only: [:index]

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :projects, only: [:show, :index, :create]
    end
  end
end

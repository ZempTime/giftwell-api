Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :gifts
      end

      namespace :users do
        resources :registrations, only: [:create, :update, :destroy]
        resources :sessions, only: [:create]
      end
    end
  end
end

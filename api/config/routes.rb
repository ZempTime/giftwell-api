Rails.application.routes.draw do
  namespace :api do

    resources :relationships do
      get :friends,             to: "relationships/friends#index",            on: :collection
      get :received_requests,   to: "relationships/received_requests#index",  on: :collection
      get :sent_requests,       to: "relationships/sent_requests#index",      on: :collection
      put :approve,             to: "relationships/approves#update",          on: :member
      put :decline,             to: "relationships/declines#update",          on: :member
    end

    resources :users, only: [] do
      resources :gifts
    end

    namespace :users do
      resources :registrations, only: [:create, :update, :destroy]
      resources :sessions, only: [:create]
    end
  end
end

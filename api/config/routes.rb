Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :gifts
        get :friends, to: "relationships#index", on: :member
      end

      resources :relationships do
        get :pending_requests,  to: "relationships/pending_requests#index", on: :collection
        get :sent_requests,     to: "relationships/sent_requests#index",    on: :collection
        put :approve,            to: "relationships/approves#update",        on: :member
        put :reject,            to: "relationships/rejects#update",         on: :member
      end

      namespace :users do
        resources :registrations, only: [:create, :update, :destroy]
        resources :sessions, only: [:create]
      end
    end
  end
end

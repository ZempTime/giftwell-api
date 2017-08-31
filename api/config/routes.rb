Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :gifts
        resources :relationships do
          get :pending_requests,  to: "relationships/pending_requests#index", on: :collection
          get :sent_requests,     to: "relationships/sent_requests#index",    on: :collection
          put :accept,            to: "relationships/accepts#update",         on: :member
          put :reject,            to: "relationships/rejects#update",         on: :member
          put :block,             to: "relationships/blocks#update",          on: :member
        end
        get :friends, to: "relationships#index", on: :member
      end

      namespace :users do
        resources :registrations, only: [:create, :update, :destroy]
        resources :sessions, only: [:create]
      end
    end
  end
end

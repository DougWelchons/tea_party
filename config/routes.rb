Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :subscriptions, only: [:create, :update]
      resources :customers, only: [] do
        resources :subscriptions, only: [:index]
      end
    end
  end
end

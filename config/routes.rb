Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      get "merchants/find", to: "merchant_search#find"
      get "merchants/find_all", to: "merchant_search#find_all"
      resources :merchants, only: [:index, :show] do
        resources :items, module: :merchants, only: [:index]
      end

      get "items/find", to: "item_search#find"
      get "items/find_all", to: "item_search#find_all"
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        get "/merchant", to: "items_merchant#show"
      end
    end
  end
end

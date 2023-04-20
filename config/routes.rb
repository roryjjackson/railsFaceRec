Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :photos do
        post 'celebrityApi', on: :collection
      end

    end
  end
  resources :celebrities
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

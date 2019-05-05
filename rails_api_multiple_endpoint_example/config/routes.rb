Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :mobile do
        resources :users
      end

      namespace :react do
        resources :users
      end

      namespace :web do
        resources :users
      end
    end

    namespace :v2 do
      namespace :mobile do
        resources :users
      end

      namespace :react do
        resources :users
      end

      namespace :web do
        resources :users
      end
    end
  end
end

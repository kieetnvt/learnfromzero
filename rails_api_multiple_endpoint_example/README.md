# README

## Rails API Multiple Endpoint Example

- https://en.wikibooks.org/wiki/Ruby_Programming/Unit_testing

- https://github.com/rails-api/active_model_serializers/blob/v0.10.6/docs/general

- https://www.sitepoint.com/dry-off-your-rails-code-with-activesupportconcerns

## Implement multiple api endpoint & versioning

#### Controllers structure

- app

  - controllers
  
    - api
    
      - v1
      
        - mobile
          
          - users_controller.rb
          
        - react
        
          - users_controller.rb
          
        - web
        
          - users_controller.rb
          
      - v2
      
        - mobile
          
          - users_controller.rb
          
        - react
        
          - users_controller.rb
          
        - web
        
          - users_controller.rb
        
### Source example:

```
# app/controllers/api/v1/mobile/users_controller.rb
module Api
  module V1
    module Mobile
      class UsersController < ApplicationController
        include UserableCrudAction

        def index
          @users = User.all
          render json: @users
        end

        # override the action show from default crud
        api :GET, '/users/:id', 'id of the requested user test'
        param :id, :number
        def show
          super
        end
      end
    end
  end
end

# app/controllers/api/v2/mobile/users_controller.rb inherit v1 
module Api
  module V2
    module Mobile
      class UsersController < Api::V1::Mobile::UsersController
        def index
          render json: 'V2 override V1'
        end

        def show
          render json: 'V2 override V1'
        end
      end
    end
  end
end
```

### Routes:

```
Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :mobile do
        resources :users
        resources :companies
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
```

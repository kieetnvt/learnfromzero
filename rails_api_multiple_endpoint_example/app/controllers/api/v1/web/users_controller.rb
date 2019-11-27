module Api
  module V1
    module Web
      class UsersController < ApplicationController
        include UserableCrudAction

        def index
          @users = [1,2,3]
          # { "action":"V1 Index", "users":[1,2,3] }
          render json: @users
        end
      end
    end
  end
end

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


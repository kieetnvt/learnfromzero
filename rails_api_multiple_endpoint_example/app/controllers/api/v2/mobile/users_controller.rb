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
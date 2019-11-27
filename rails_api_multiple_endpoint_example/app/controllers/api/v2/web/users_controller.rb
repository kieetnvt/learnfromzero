module Api
  module V2
    module Web
      class UsersController < Api::V1::Web::UsersController
        def index
          @users = [10,20,30]
          super
          # {"action":"V1 Index","users":[10,20,30]}
        end
      end
    end
  end
end
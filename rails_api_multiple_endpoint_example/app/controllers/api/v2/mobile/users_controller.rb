class Api::V2::Mobile::UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users, each_serializer: TestTwoSerializer
  end
end

class Api::V1::Mobile::UsersController < ApplicationController
  include UserableCrudAction

  # override the action show from default crud
  api :GET, '/users/:id', 'id of the requested user test'
  param :id, :number

  def index
    @users = User.all
    render json: @users, serializer: TestOneSerializer
  end

  def show
    # if you want fatherrun - just call super to default action
    super
    # else
    # response_json(@user.attributes.merge({override: {action: :show, flag: 'v1/mobile'}}))
  end
end

class Api::V1::React::UsersController < ApplicationController
  include UserableCrudAction

  # override the action show from default crud
  # if you want fatherrun - just call super to default action
  # super
  # else
  # something different
  def show
    # -> this case not use serializer
    response_json(@user.attributes.merge({override: {action: :show, flag: 'v1/react'}}))
  end
end

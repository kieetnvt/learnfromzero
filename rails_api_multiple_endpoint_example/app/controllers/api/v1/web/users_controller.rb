class Api::V1::Web::UsersController < ApplicationController
  include UserableCrudAction

  def show
    super
  end
end

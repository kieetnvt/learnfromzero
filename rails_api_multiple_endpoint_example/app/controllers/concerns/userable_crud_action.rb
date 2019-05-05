module UserableCrudAction
  extend Apipie::DSL::Concern # to writing doc Apipie for Concerns Action (top)
  extend ActiveSupport::Concern # provides the more graceful `included` method (bottom)

  included do
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  end

  api :GET, '/:users', 'List users'
  def index
    @users = User.all
    response_json(@users)
  end

  api :GET, '/users/:id', 'id of the requested user'
  param :id, :number
  def show
    response_json(@user)
  end

  def new
    @user = User.new
    response_json(@user)
  end

  def create
    @user = User.create!(user_params)
    response_json(@user, :created)
  end

  def edit
    response_json(@user, :edit)
  end

  def update
    @user.update!(user_params)
    response_json(@user, :updated)
  end

  def destroy
    @user.destroy!
    response_json(:destroyed)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
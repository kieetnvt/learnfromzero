module ResponseJson
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  def response_json(object, status = :ok)
    render json: object, status: status
  end
end
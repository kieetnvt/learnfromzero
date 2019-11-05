class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :model_name, :serializer_name, :serializer_path

  def model_name
    object.class.to_s
  end

  def serializer_name
    "UserSerializer"
  end

  def serializer_path
    "app/serializers/user_serializer"
  end
end

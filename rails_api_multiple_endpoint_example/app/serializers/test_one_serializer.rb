class TestOneSerializer < ActiveModel::Serializer
  attributes :model_name, :serializer_name, :serializer_path, :users

  def users
    object
  end

  def model_name
    object.class.to_s
  end

  def serializer_name
    "TestOneSerializer"
  end

  def serializer_path
    "app/serializers/test_one_serializer"
  end
end

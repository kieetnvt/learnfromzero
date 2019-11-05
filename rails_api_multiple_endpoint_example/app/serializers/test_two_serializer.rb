class TestTwoSerializer < ActiveModel::Serializer
  attributes :id, :model_name, :serializer_name, :serializer_path, :object_attributes

  def object_attributes
    Api::V1::Mobile::UserSerializer.new(object)
  end

  def serializer_name
    "TestTwoSerializer"
  end

  def serializer_path
    "app/serializers/test_two_serializer"
  end
end
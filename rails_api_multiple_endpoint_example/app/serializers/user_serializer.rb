class UserSerializer < ActiveModel::Serializer
  attributes :id, :test

  def test
    "The Root UserSerializer"
  end
end

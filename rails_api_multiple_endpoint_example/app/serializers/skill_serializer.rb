class SkillSerializer < ActiveModel::Serializer
  attributes :name, :model_name, :serializer_name, :serializer_path

  def model_name
    object.class.to_s
  end

  def serializer_name
    "SkillSerializer"
  end

  def serializer_path
    "app/serializers/skill_serializer"
  end
end

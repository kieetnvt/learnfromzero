class User < ApplicationRecord
  has_many :user_skills
  has_many :skills, through: :user_skills
  belongs_to :company
end

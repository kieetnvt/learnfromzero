class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email
  has_many :topics
  has_many :posts, through: :topics
end

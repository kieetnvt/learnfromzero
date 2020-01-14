class TodoList < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  has_many :items, dependent: :destroy
end

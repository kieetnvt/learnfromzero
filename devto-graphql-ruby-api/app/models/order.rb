class Order < ApplicationRecord
  has_many :payments
end

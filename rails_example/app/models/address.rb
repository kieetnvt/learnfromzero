class Address < ApplicationRecord
  belongs_to :belongable, optional: true
end

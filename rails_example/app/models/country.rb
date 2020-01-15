class Country < Address
  has_many :provinces, as: :belongable
end

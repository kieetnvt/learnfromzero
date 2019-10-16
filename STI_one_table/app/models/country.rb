class Country < Address
  has_many :provinces, as: :addressable_ref
end

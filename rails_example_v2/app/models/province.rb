class Province < Address
  belongs_to :country, foreign_key: 'belongable_id'
  has_many :cities, as: :belongable
end

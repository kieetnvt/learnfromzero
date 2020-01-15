class City < Address
  belongs_to :province, foreign_key: 'belongable_id'
  has_many :streets, as: :belongable
end

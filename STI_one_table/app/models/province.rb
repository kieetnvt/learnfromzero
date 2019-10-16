class Province < Address
  belongs_to :country, foreign_key: :addressable_ref_id
  has_many :cities, as: :addressable_ref
end

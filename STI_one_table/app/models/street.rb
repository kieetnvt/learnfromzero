class Street < Address
  belongs_to :city, foreign_key: :addressable_ref_id
end

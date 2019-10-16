class City < Address
  belongs_to :province, foreign_key: :addressable_ref_id
  has_many :streets, as: :addressable_ref
end

class Address < ApplicationRecord
  belongs_to :addressable_ref, polymorphic: true, optional: true
end

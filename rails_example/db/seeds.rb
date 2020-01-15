ActiveRecord::Base.transaction do
  country = Country.create!(name: Faker::Address.country)
  province = country.provinces.create!(name: Faker::Address.state)
  city = province.cities.create!(name: Faker::Address.city)
  street = city.streets.create!(name: Faker::Address.street_address)
end


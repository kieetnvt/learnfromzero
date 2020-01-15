class Street < Address
  belongs_to :city, foreign_key: 'belongable_id'

  def country
    sql = <<-SQL
      SELECT * FROM addresses country
      WHERE country.type='Country' and country.id in (
        SELECT province.belongable_id FROM addresses province
        WHERE province.type='Province' and province.id in (
          SELECT city.belongable_id from addresses city
          WHERE city.type='City' and city.id = '#{self.belongable_id}'
        )
      )
    SQL
    ActiveRecord::Base.connection.execute(sql).values
    # [[1, "Country", "Argentina", nil, nil, "2020-01-11 06:24:48.419706", "2020-01-11 06:24:48.419706"]]
  end

  def country_by_recursive
    sql = <<-SQL
      WITH RECURSIVE subordinates AS (
        SELECT
          id, type, name, belongable_id, belongable_type
        FROM
          addresses
        WHERE
          addresses.id = '#{self.id}'
        UNION
          SELECT
            a.id, a.type, a.name, a.belongable_id, a.belongable_type
          FROM
            addresses a
          INNER JOIN subordinates s ON a.id = s.belongable_id
        ) SELECT * FROM subordinates
      SQL
    ActiveRecord::Base.connection.execute(sql).values
    # [[4, "Street", "128 Metz Cliff", 3, "Address"], [3, "City", "Schroedertown", 2, "Address"], [2, "Province", "California", 1, "Address"], [1, "Country", "Argentina", nil, nil]]
  end
end

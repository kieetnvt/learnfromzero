class Vehicle
  attr_accessor :type, :color, :price
  def initialize(color=nil, price=nil)
    @color = color
    @price = price
  end
end

class Car < Vehicle
end

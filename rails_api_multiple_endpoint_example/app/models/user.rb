class User < ApplicationRecord
  def upcase_name
    self.name.upcase
  end
end

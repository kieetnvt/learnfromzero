require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "example testing with ruby unit_test" do
    assert_equal("TEST", User.create(name: "test", email: "test@test.com").upcase_name)
  end
end

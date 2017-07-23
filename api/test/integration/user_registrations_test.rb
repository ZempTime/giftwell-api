require 'test_helper'

class UserRegistrationsTest < ActionDispatch::IntegrationTest
  test "user with valid credentials can log in" do

    post "/api/v1/user_token", params:
      {
        auth: {
          email: users(:chris).email,
          password: "password"
        }
      }

    assert_equal 201, response.status
    assert json.has_key?("jwt")
  end

  test "user with invalid credentials can't log in" do
    post "/api/v1/user_token", params:
      {
        auth: {
          email: "notexist@nowhere.com",
          password: "password"
        }
      }

    assert_equal 404, response.status
  end
end

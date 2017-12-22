require 'test_helper'

module Users
  class SessionsTest < ActionDispatch::IntegrationTest
    test "user with valid credentials can log in" do

      post "/api/users/sessions", params:
        {
        user: {
          email: users(:chris).email,
          password: "password"
        }
      }

        assert_equal 201, response.status
        assert json.has_key?("jwt")
    end

    test "user with invalid credentials can't log in" do
      post "/api/users/sessions", params:
        {
        user: {
          email: "notexist@nowhere.com",
          password: "password"
        }
      }

        assert_equal 401, response.status
    end
  end
end

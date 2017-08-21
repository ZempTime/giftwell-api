require "test_helper"

class UserRegistrationsTest < ActionDispatch::IntegrationTest

  test "user with valid credentials can sign up" do

    post "/api/v1/users/registrations", params:
      {
        user: {
          name: "Chris Zempel",
          email: "test+chris.m.zempel@gmail.com",
          password: "password",
          password_confirmation: "password",
          born_at: 20.years.ago.iso8601,
          invitation_token: "token"
        }
      }

    assert_equal 201, response.status
    assert json.has_key?("jwt")
  end

  test "not matching password confirmation" do

    post "/api/v1/users/registrations", params:
      {
        user: {
          name: "Chris Zempel",
          email: "test+chris.m.zempel@gmail.com",
          password: "password",
          password_confirmation: "password11",
          born_at: 20.years.ago.iso8601,
          invitation_token: "token"
        }
      }

    assert_equal 200, response.status
  end

  test "invalid email" do
  end
end

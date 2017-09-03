require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all

  def json
    JSON.parse(response.body)
  end

  def sign_in(user)
    post "/api/v1/users/sessions", params: {
      user: {
      email: users(:chris).email,
      password: "password"
      }
    }

    json["jwt"]
  end
end

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  self.set_fixture_class users: Physical::User

  fixtures :all

  def json
    JSON.parse(response.body)
  end
end

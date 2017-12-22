require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'support/session_helpers'

class ActiveSupport::TestCase
  fixtures :all

  def json
    JSON.parse(response.body)
  end
end

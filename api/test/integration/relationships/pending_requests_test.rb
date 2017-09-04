require "test_helper"

module Relationships
  class PendingRequestsTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    def setup
      sign_in(users(:chris))
    end

    test "returns a list of pending relationship requests" do
    end
  end
end

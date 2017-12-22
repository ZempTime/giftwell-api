require "test_helper"

module Relationships
  class ReceivedRequestsTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    def setup
      sign_in(users(:chris))
    end

    test "returns a list of all pending received relationship requests" do
      expected_relationships = [relationships(:relationship_sue_chris).id].sort

      get "/api/relationships/received_requests",
        headers: authorization_header

      assert_equal expected_relationships, json["data"].map { |relationship| relationship["id"].to_i}.sort
    end
  end
end

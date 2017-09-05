require "test_helper"

module Relationships
  class SentRequestsTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    def setup
      sign_in(users(:chris))
    end

    test "returns a list of all pending sent relationship requests" do
      expected_relationships = [relationships(:relationship_chris_ellie).id].sort

      get "/api/relationships/sent_requests",
        headers: authorization_header

      assert_equal expected_relationships, json["data"].map { |relationship| relationship["id"].to_i}.sort
    end
  end
end

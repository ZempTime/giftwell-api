require "test_helper"

module Relationships
  class FriendsTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    def setup
      sign_in(users(:chris))
    end

    test "returns a list of all pending sent relationship requests" do
      expected_relationships = [relationships(:relationship_chris_will).id].sort

      get "/api/relationships/friends",
        headers: authorization_header

      assert_equal expected_relationships, json["data"].map { |relationship| relationship["id"]}.sort
    end
  end
end

require "test_helper"

module Relationships
  class ApprovesTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    def setup
      sign_in(users(:chris))
    end

    test "user can approve a pending friend request sent by another user" do
      relationship = relationships(:relationship_sue_chris)
      assert_equal "pending", relationship.status

      put "/api/relationships/#{relationship.id}/approve",
        headers: authorization_header

      assert_equal 200, response.status
      assert_equal relationship.id, json["id"]
      assert_equal "approved", json["status"]
      relationship.reload
      assert relationship.status, "approved"
    end

    test "user can't approve a friend request they made" do
      relationship = relationships(:relationship_chris_ellie)
      assert_equal "pending", relationship.status

      put "/api/relationships/#{relationship.id}/approve",
        headers: authorization_header

      assert_equal 200, response.status
      assert json["errors"].any? { |error| error["detail"] == "User can't approve a relationship they requested." }, "Expected an error around what user can approve this relationship."
    end

    test "attempting to accept a relationship that's already been approved will return that relationship unmodified" do
      relationship = relationships(:relationship_chris_will)
      assert_equal users(:will), relationship.action_user
      assert_equal "approved", relationship.status

      put "/api/relationships/#{relationship.id}/approve",
        headers: authorization_header

      assert_equal 200, response.status
      assert_equal relationship.id, json["id"]
      assert_equal users(:will).id, json["action_user_id"]
      assert_equal "approved", json["status"]
    end
  end
end

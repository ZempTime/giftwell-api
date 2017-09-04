require "test_helper"

module Relationships
  class DeclinesTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    def setup
      sign_in(users(:chris))
    end

    test "user can decline a pending friend request sent by another user" do
      relationship = relationships(:relationship_sue_chris)
      assert_equal "pending", relationship.status

      put "/api/v1/relationships/#{relationship.id}/decline",
        headers: authorization_header

      assert_equal 200, response.status
      assert_equal relationship.id, json["id"]
      assert_equal "declined", json["status"]
      relationship.reload
      assert relationship.status, "declined"
    end

    test "user can't decline a friend request they made" do
      relationship = relationships(:relationship_chris_ellie)
      assert_equal "pending", relationship.status

      put "/api/v1/relationships/#{relationship.id}/decline",
        headers: authorization_header

      assert_equal 200, response.status
      assert json["errors"].any? { |error| error["detail"] == "User can't decline a relationship they requested." },
        "Expected an error around what user can decline this relationship."
    end

    test "attempting to decline a relationship that's already been declined will return that relationship unmodified" do
      relationship = relationships(:relationship_chris_joe)
      assert_equal users(:joe).id, relationship.action_user_id
      assert_equal "declined", relationship.status

      put "/api/v1/relationships/#{relationship.id}/decline",
        headers: authorization_header

      assert_equal 200, response.status
      assert_equal relationship.id, json["id"]
      assert_equal users(:joe).id, json["action_user_id"]
      assert_equal "declined", json["status"]
    end
  end
end

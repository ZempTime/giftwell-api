require "test_helper"

class RelationshipsTest < ActionDispatch::IntegrationTest
  include SessionHelpers

  def setup
    sign_in(users(:chris))
  end

  test "make a friend request" do
    refute Relationship.flexible_where(users(:chris), users(:john)).any?, "Expected no relationships to exist between these users."

    assert_difference('Relationship.count', 1) do
      post "/api/v1/relationships",
        params: {
          requested_user_id: users(:john).id
        },
        headers: authorization_header
    end

    assert_equal 201, response.status
    assert Relationship.flexible_where(users(:chris), users(:john)).any?, "Expected a relationship to exist between these users."
  end

  test "attempting to make a friend request that already exists returns that friend request" do
    assert Relationship.flexible_where(users(:chris), users(:ellie)).any?, "Expected a relationship to exist between these users."
    assert_difference('Relationship.count', 0) do
      post "/api/v1/relationships",
        params: {
          requested_user_id: users(:ellie).id
        },
        headers: authorization_header
    end

    assert_equal 200, response.status
    assert_equal relationships(:relationship_chris_ellie).id, json["id"]
  end

  #test "reject a friend request" do
    #relationship = relationships(:relationship_chris_ellie)
    #assert_equal relationship.status, "pending"

    #put "/api/v1/relationships/#{relationship.id}/accept",
      #headers: authorization_header

    #assert_equal 200, response.status
    #assert_equal "accepted", json["status"]
  #end
  #test "view pending requests"
  #test "view pending sent requests"
  #test "friends list"
end

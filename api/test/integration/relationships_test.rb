require "test_helper"

class RelationshipsTest < ActionDispatch::IntegrationTest
  include SessionHelpers

  def setup
    sign_in(users(:chris))
  end

  test "make a friend request" do
    refute Relationship.flexible_where(users(:chris), users(:john)).any?, "Expected no relationships to exist between these users."

    assert_difference('Relationship.count', 1) do
      post "/api/relationships",
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
      post "/api/relationships",
        params: {
          requested_user_id: users(:ellie).id
        },
        headers: authorization_header
    end

    assert_equal 200, response.status
    assert_equal relationships(:relationship_chris_ellie).id, json["data"]["id"].to_i
  end

  test "get all relationships" do
    expected_relationships = [
      relationships(:relationship_chris_ellie).id,
      relationships(:relationship_chris_will).id,
      relationships(:relationship_chris_joe).id,
      relationships(:relationship_sue_chris).id
    ].sort

    get "/api/relationships",
      headers: authorization_header

    assert_equal expected_relationships, json["data"].map { |relationship| relationship["id"].to_i}.sort
  end

  test "user can delete a relationship they're involved in" do
    assert_difference('Relationship.count', -1) do
      delete "/api/relationships/#{relationships(:relationship_chris_will).id}",
        headers: authorization_header
    end

    assert_equal 204, response.status
  end

  test "user can't delete a relationship they're not involved in" do
    assert_difference('Relationship.count', 0) do
      delete "/api/relationships/#{relationships(:relationship_ellie_will).id}",
        headers: authorization_header
    end

    assert_equal 404, response.status
  end
end

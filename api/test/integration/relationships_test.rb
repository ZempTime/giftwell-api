require "test_helper"

class RelationshipsTest < ActionDispatch::IntegrationTest
  def setup
    @jwt = sign_in(users(:chris))
  end

  def authorization_header
    { "HTTP_AUTHORIZATION" => @jwt }
  end

  test "make a friend request" do
    refute Relationship.flexible_where(users(:chris), users(:sue)).any?, "Expected no relationships to exist between these users."

    assert_difference('Relationship.count', 1) do
      post "/api/v1/relationships",
        params: {
          requested_user_id: users(:sue).id
        },
        headers: authorization_header
    end
    assert Relationship.flexible_where(users(:chris), users(:sue)).any?, "Expected a relationship to exist between these users."
  end
  #test "accept a friend request"
  #test "reject a friend request"
  #test "view pending requests"
  #test "view pending sent requests"
  #test "friends list"
end

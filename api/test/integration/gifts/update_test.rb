require "test_helper"

module Gifts
  class UpdateTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    test "user can update gifts they've authored" do
      sign_in(users(:chris))

      put "/api/users/#{users(:chris).id}/gifts/#{gifts(:user_authored).id}",
        headers: authorization_header,
        params: {
          name: "Jello",
        }

      assert_equal 200, response.status
      assert_equal "Jello", Gift.find(gifts(:user_authored).id).name
    end

    test "friends can update gifts they've authored" do
      sign_in(users(:will))

      put "/api/users/#{users(:chris).id}/gifts/#{gifts(:friend_authored).id}",
        headers: authorization_header,
        params: {
          name: "Jello",
        }

      assert_equal 200, response.status
      assert_equal "Jello", Gift.find(gifts(:friend_authored).id).name
    end

    test "users can't update gifts they haven't authored" do
      sign_in(users(:will))

      put "/api/users/#{users(:chris).id}/gifts/#{gifts(:user_authored).id}",
        headers: authorization_header,
        params: {
          name: "Jello",
        }

      assert_equal 403, response.status
    end

    test "requires a name" do
      sign_in(users(:chris))

      put "/api/users/#{users(:chris).id}/gifts/#{gifts(:user_authored).id}",
        headers: authorization_header,
        params: {
          name: ""
        }

      assert_equal 200, response.status
      assert json["errors"].any? { |error| error["detail"] == "can't be blank" }, "Expected a presence validation error."
    end
  end
end


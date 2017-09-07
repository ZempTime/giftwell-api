require "test_helper"

module Gifts
  class DestroyTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    test "a user can mark their friend's gift as redeemed" do
      sign_in(users(:will))
      put "/api/users/#{users(:chris).id}/gifts/#{gifts(:friend_authored).id}/redeem",
        headers: authorization_header

      assert_equal 200, response.status
      assert_equal "redeemed", json["data"]["attributes"]["status"]
    end

    test "non friends can't redeem gifts" do
      sign_in(users(:ellie))
      put "/api/users/#{users(:chris).id}/gifts/#{gifts(:friend_authored).id}/redeem",
        headers: authorization_header

      assert_equal 403, response.status
    end
  end
end

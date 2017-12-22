require "test_helper"

module Gifts
  class RedeemTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    test "a user can mark their friend's gift as redeemed" do
      sign_in(users(:will))
      put "/api/users/#{users(:chris).id}/gifts/#{gifts(:friend_authored).id}/redeem",
        params: {
          published_at: DateTime.now.iso8601
        },
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

    test "requires a published_at date" do
      sign_in(users(:will))
      put "/api/users/#{users(:chris).id}/gifts/#{gifts(:unredeemed_gift).id}/redeem",
        headers: authorization_header

      assert_equal 200, response.status
      assert json["errors"].any? { |error| error["detail"] == "can't be blank" }, "Expected an error around needing the published_at date."
    end

    test "can only redeem a gift if it's previous status is requested" do
      sign_in(users(:will))
      put "/api/users/#{users(:chris).id}/gifts/#{gifts(:redeemed_gift).id}/redeem",
        headers: authorization_header

      assert_equal 200, response.status
      assert json["errors"].any? { |error| error["detail"] == "User can only redeem previously requested gifts. Previous status was: redeemed." }, "Expected an error around the gift being only redeemable from a requested status."
    end
  end
end

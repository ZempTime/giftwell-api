require "test_helper"

module Gifts
  class IndexFriendTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    def setup
      sign_in(users(:will))
    end

    test "gives back gifts authored by user and friends" do
      expected_gifts = [gifts(:user_authored).id, gifts(:friend_authored).id, gifts(:unredeemed_gift).id, gifts(:redeemed_gift).id].sort

      get "/api/users/#{users(:chris).id}/gifts", headers: authorization_header

      assert_equal 200, response.status
      assert_equal expected_gifts, json["data"].map { |gift| gift["id"].to_i}.sort
    end

    test "gifts contain status information" do
      get "/api/users/#{users(:chris).id}/gifts", headers: authorization_header

      assert_equal 200, response.status

      json["data"].each do |gift|
        assert gift["attributes"].has_key?("status"), "Expected gift #{gift["id"]} to have its status field"
      end
    end
  end
end

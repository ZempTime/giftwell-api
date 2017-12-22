require "test_helper"

module Gifts
  class IndexAuthorTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    def setup
      sign_in(users(:chris))
    end

    test "gives back all gifts authored by the user" do
      expected_gifts = [gifts(:user_authored).id].sort

      get "/api/users/#{users(:chris).id}/gifts", headers: authorization_header

      assert_equal 200, response.status
      assert_equal expected_gifts, json["data"].map { |gift| gift["id"].to_i}.sort
    end

    test "only published gifts contain status information" do
      get "/api/users/#{users(:chris).id}/gifts", headers: authorization_header

      assert_equal 200, response.status

      skip
    end
  end
end

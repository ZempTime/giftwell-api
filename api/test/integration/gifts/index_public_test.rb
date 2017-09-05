require "test_helper"

module Gifts
  class IndexPublicTest < ActionDispatch::IntegrationTest
    test "gives back all gifts authored by the user" do
      expected_gifts = [gifts(:user_authored).id].sort

      get "/api/users/#{users(:chris).id}/gifts"

      assert_equal 200, response.status
      assert_equal expected_gifts, json["data"].map { |gift| gift["id"].to_i}.sort
    end

    test "gifts contain no status information" do
      get "/api/users/#{users(:chris).id}/gifts"

      assert_equal 200, response.status

      json["data"].each do |gift|
        refute gift["attributes"].has_key?("status"), "Expected gift #{gift["id"]} not to have its status field"
      end
    end
  end
end

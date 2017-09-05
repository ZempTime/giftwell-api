require "test_helper"

module Gifts
  class DestroyTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    test "user can destroy gifts they've authored for themselves" do
      sign_in(users(:chris))

      assert_difference('Gift.count', -1) do
        delete "/api/users/#{users(:chris).id}/gifts/#{gifts(:user_authored).id}",
          headers: authorization_header
      end

      assert_equal 204, response.status
    end

    test "user can destroy gifts they've authored for friends" do
      sign_in(users(:will))

      assert_difference('Gift.count', -1) do
        delete "/api/users/#{users(:chris).id}/gifts/#{gifts(:friend_authored).id}",
          headers: authorization_header
      end

      assert_equal 204, response.status
    end

    test "users can't destroy gifts they haven't authored" do
      sign_in(users(:will))

      delete "/api/users/#{users(:chris).id}/gifts/#{gifts(:user_authored).id}",
        headers: authorization_header

      assert_equal 403, response.status
    end
  end
end

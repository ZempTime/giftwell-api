require "test_helper"

module Gifts
  class CreateTest < ActionDispatch::IntegrationTest
    include SessionHelpers

    test "author can add a gift" do
      sign_in(users(:chris))

      assert_difference('Gift.count', 1) do
        post "/api/users/#{users(:chris).id}/gifts",
          headers: authorization_header,
          params: {
            name: "Jello",
            note: "It jiggles so delightfully",
            link: "https://jello.com",
          }
      end

      assert_equal 201, response.status

      assert_equal users(:chris).id, Gift.last.author_id
      assert_equal users(:chris).id, Gift.last.recipient_id
      assert_equal "Jello", Gift.last.name
      assert_equal "It jiggles so delightfully", Gift.last.note
    end

    test "friends can add a gift" do
      sign_in(users(:will))

      assert_difference('Gift.count', 1) do
        post "/api/users/#{users(:chris).id}/gifts",
          headers: authorization_header,
          params: {
            name: "Jello",
            note: "It jiggles so delightfully",
            link: "https://jello.com",
          }
      end

      assert_equal 201, response.status

      assert_equal users(:will).id, Gift.last.author_id
      assert_equal users(:chris).id, Gift.last.recipient_id
      assert_equal "Jello", Gift.last.name
      assert_equal "It jiggles so delightfully", Gift.last.note
    end

    test "non-friend users can't add a gift" do
      sign_in(users(:joe))

      post "/api/users/#{users(:chris).id}/gifts",
        headers: authorization_header,
        params: {
          name: "Jello",
          note: "It jiggles so delightfully",
          link: "https://jello.com",
        }

      assert_equal 403, response.status
    end

    test "requires a name" do
      sign_in(users(:chris))

      post "/api/users/#{users(:chris).id}/gifts",
        headers: authorization_header,
        params: {
          note: "It jiggles so delightfully",
          link: "https://jello.com",
        }

      assert_equal 200, response.status
      assert json["errors"].any? { |error| error["detail"] == "can't be blank" }, "Expected a presence validation error."
    end
  end
end

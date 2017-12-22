require 'test_helper'

class GiftTest < ActiveSupport::TestCase
  test "recipient_is" do
    gifts = Gift.recipient_is(users(:chris).id)

    assert_includes gifts, gifts(:friend_authored)
    assert_includes gifts, gifts(:user_authored)
  end
end

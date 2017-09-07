class Api::Gifts::RedeemsController < Api::GiftsController
  skip_before_action :ensure_author
  before_action :ensure_friend

  def update
    @gift.update(status: "redeemed")

    render json: @gift, rule: rule
  end

  private
    def ensure_friend
      raise Api::GiftError::InvalidUser unless is_friend?
    end
end

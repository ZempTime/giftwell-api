class Api::Gifts::RedeemsController < Api::GiftsController
  skip_before_action :ensure_author
  before_action :ensure_friend

  def update
    if @gift.update(status: "redeemed", published_at: redeem_params[:published_at])
      render json: @gift, rule: rule
    else
      render json: @gift, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  private

    def set_gift
      super
      @gift = Gifts::Redeem.find(@gift.id)
    end

    def redeem_params
      params.permit(:published_at)
    end

    def ensure_friend
      raise Api::GiftError::InvalidUser unless is_friend?
    end
end

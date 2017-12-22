class Api::GiftsController < Api::ApiController
  # TODO: This many before_actions means it would be prudent to break this out into more/different controllers

  include UserScoped

  skip_before_action :authenticate, only: [:index]
  before_action :set_serialization_rule
  before_action :ensure_themselves_or_friend, only: [:create]
  before_action :set_gift, only: [:update, :destroy]
  before_action :ensure_author, only: [:update, :destroy]

  def index
    case rule
    when :author
      @gifts = Gift.recipient_is(@user).author_is(@user)
      render jsonapi: @gifts, fields: { gifts: AUTHOR }
    when :friend
      @gifts = Gift.recipient_is(@user)
      render jsonapi: @gifts, fields: { gifts: FRIEND }
    when :public
      @gifts = Gift.recipient_is(@user.id).author_is(@user)
      render jsonapi: @gifts, fields: { gifts: PUBLIC }
    end
  end

  def create
    @gift = Gift.new(gift_params)

    @gift.author = current_user
    @gift.recipient = @user

    if @gift.save
      render json: @gift, rule: rule, status: 201
    else
      render json: @gift, status: 200, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  def update
    if @gift.update(gift_params)
      render json: @gift, rule: rule
    else
      render json: @gift, status: 200, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  def destroy
    if @gift.destroy
      render :nothing, status: :no_content
    else
      render json: @gift, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  private

  def set_serialization_rule
    case
    when is_author?
      @rule = :author
    when is_friend?
      @rule = :friend
    else
      @rule = :public
    end
  end

  def rule
    @rule ||= :public
  end

  def is_author?
    current_user && current_user == @user
  end

  def is_friend?
    current_user && @user.friends.include?(current_user)
  end

  def gift_params
    params.permit(Gift::PERMITTED_PARAMS)
  end

  def ensure_themselves_or_friend
    raise Api::GiftError::InvalidUser unless is_author? || is_friend?
  end

  def set_gift
    @gift = @user.gifts.find(params[:id])
  end

  def ensure_author
    raise Api::GiftError::InvalidAuthor unless @gift.author == current_user
  end

  AUTHOR = [
    :id,
    :name,
    :note,
    :link,
    :position,
    :created_at,
    :recipient_id
  ]

  PUBLIC = [
    :id,
    :name,
    :note,
    :link,
    :position,
    :created_at,
    :recipient_id
  ]

  FRIEND = [
    :id,
    :name,
    :note,
    :link,
    :position,
    :status,
    :recipient_id,
    :author_id,
    :created_at,
    :updated_at
  ]
end

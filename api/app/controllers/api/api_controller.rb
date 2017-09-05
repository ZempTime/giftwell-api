class Api::ApiController < ApplicationController
  before_action :set_default_format
  before_action :authenticate

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {title: "RecordNotFound", message: "Unable to find requested relationship."}, status: :not_found
  end

  rescue_from Api::GiftError::InvalidUser do |exception|
    render json: {title: 'GiftError::InvalidUser', message: exception.message}, status: :forbidden
  end

  rescue_from Api::GiftError::InvalidAuthor do |exception|
    render json: {title: 'GiftError::InvalidAuthor', message: exception.message}, status: :forbidden
  end

  def logged_in?
    !!current_user
  end

  def current_user
    if auth_present?
      user = User.find(auth["user"])
      if user
        @current_user ||= user
      end
    end
  end

  def authenticate
    render json: {error: "unauthorized"}, status: 401 unless logged_in?
  end

  private

    def set_default_format
      request.format = :json
    end

    def auth
      Auth.decode(request.authorization)
    end

    def auth_present?
      !!request.authorization
    end
end

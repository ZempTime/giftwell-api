class Api::V1::ApiController < ApplicationController
  before_action :set_default_format
  before_action :authenticate

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

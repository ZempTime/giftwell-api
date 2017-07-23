class Api::V1::ApiController < ApplicationController
  include Knock::Authenticatable

  before_action :authenticate_user
  before_action :set_default_format

  private

    def set_default_format
      request.format = :json
    end
end

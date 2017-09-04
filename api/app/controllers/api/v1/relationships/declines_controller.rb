class Api::V1::Relationships::DeclinesController < Api::V1::ApiController
  before_action :set_relationship

  def update
    if @relationship.update(status: "declined", action_user: current_user)
      render json: @relationship
    else
      render json: @relationship, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  private
    def set_relationship
      @relationship = Relationships::Decline.find(params[:id])
    end
end

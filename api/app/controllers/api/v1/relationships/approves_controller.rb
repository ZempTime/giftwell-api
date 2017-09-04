class Api::V1::Relationships::ApprovesController < Api::V1::ApiController
  before_action :set_relationship

  def update
    if @relationship.update(status: "approved", action_user: current_user)
      render json: @relationship
    else
      render json: @relationship, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  private
    def set_relationship
      @relationship = Relationships::Approve.find(params[:id])
    end
end

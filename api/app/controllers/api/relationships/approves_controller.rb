class Api::Relationships::ApprovesController < Api::ApiController
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

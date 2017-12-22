class Api::Relationships::DeclinesController < Api::ApiController
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

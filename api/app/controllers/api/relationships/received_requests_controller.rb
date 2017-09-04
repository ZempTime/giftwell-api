class Api::Relationships::ReceivedRequestsController < Api::ApiController
  def index
    @relationships = Relationship
      .pending
      .involving(current_user.id)
      .received_by(current_user.id)

    render json: @relationships
  end
end

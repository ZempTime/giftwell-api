class Api::Relationships::SentRequestsController < Api::ApiController
  def index
    @relationships = Relationship
      .pending
      .involving(current_user.id)
      .sent_by(current_user.id)

    render json: @relationships
  end
end

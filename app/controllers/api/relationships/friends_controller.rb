class Api::Relationships::FriendsController < Api::ApiController
  def index
    @relationships = Relationship
      .approved
      .involving(current_user.id)

    render json: @relationships
  end
end

class Api::V1::RelationshipsController < Api::V1::ApiController
  before_action :set_requested_user

  def create
    @relationship = Relationship.flexible_where(current_user, @requested_user).first_or_initialize
    @relationship.action_user = current_user
    status = @relationship.persisted? ? 200 : 201

    if @relationship.save
      render json: @relationship, status: status
    else
      render json: @relationship, status: 200, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  def set_requested_user
    @requested_user = User.find(params[:requested_user_id])
  end
end

class Api::RelationshipsController < Api::ApiController
  before_action :set_requested_user, only: [:create]

  def index
    @relationships = Relationship.involving(current_user.id)

    render jsonapi: @relationships
  end

  def create
    @relationship = Relationship.flexible_where(current_user, @requested_user).first_or_initialize
    @relationship.action_user = current_user
    status = @relationship.persisted? ? 200 : 201

    if @relationship.save
      render jsonapi: @relationship, status: status
    else
      render jsonapi_errors: @relationship.errors
    end
  end

  def destroy
    @relationship = Relationship.involving(current_user.id).find(params[:id])

    if @relationship.destroy
      render :nothing, status: :no_content
    else
      render jsonapi_errors: @relationship.errors
    end
  end

  private
    def set_requested_user
      @requested_user = User.find(params[:requested_user_id])
    end
end

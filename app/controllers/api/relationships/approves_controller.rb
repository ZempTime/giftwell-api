class Api::Relationships::ApprovesController < Api::ApiController
  before_action :set_relationship

  def update
    if @relationship.update(status: "approved", action_user: current_user)
      render jsonapi: @relationship, class: { 'Relationship::Approve': SerializableRelationship }
    else
      render jsonapi_errors: @relationship.errors
    end
  end

  private
    def set_relationship
      @relationship = Relationships::Approve.find(params[:id])
    end
end

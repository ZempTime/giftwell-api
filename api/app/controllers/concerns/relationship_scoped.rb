module RelationshipScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_relationship
  end

  def set_relationship
    id = params[:relationship_id]
    id ||= params[:id]
    @relationship = Relationship.find(id)
  end
end

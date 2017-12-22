class SerializableRelationship < JSONAPI::Serializable::Resource
  type 'relationships'

  attributes :id, :user_one_id, :user_two_id, :status, :action_user_id, :relation_id, :created_at, :updated_at

  belongs_to :user_one
  belongs_to :user_two
  belongs_to :action_user
  belongs_to :relation
end

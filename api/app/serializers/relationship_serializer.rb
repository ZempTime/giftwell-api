class RelationshipSerializer < ActiveModel::Serializer
  attributes :id, :user_one_id, :user_two_id, :status, :action_user_id, :relation_id, :created_at, :updated_at
end

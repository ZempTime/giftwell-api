class SerializableGift < JSONAPI::Serializable::Resource
  attributes :id, :name, :note, :link, :position, :status, :recipient_id, :author_id, :created_at, :updated_at

  belongs_to :author
  belongs_to :recipient
end

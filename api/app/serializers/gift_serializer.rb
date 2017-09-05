class GiftSerializer < ActiveModel::Serializer
  attributes :id, :name, :note, :link, :position, :status, :recipient_id, :author_id, :created_at, :updated_at

  def attributes(*args)
    hash = super
    hash.select {|k,v| rule.include?(k) }
  end

  def rule
    rule = instance_options[:rule].upcase.to_s
    rule ||= PUBLIC
    "GiftSerializer::#{rule}".constantize
  end

  AUTHOR = [
    :id,
    :name,
    :note,
    :link,
    :position,
    :created_at,
    :recipient_id
  ]

  PUBLIC = [
    :id,
    :name,
    :note,
    :link,
    :position,
    :created_at,
    :recipient_id
  ]

  FRIEND = [
    :id,
    :name,
    :note,
    :link,
    :position,
    :status,
    :recipient_id,
    :author_id,
    :created_at,
    :updated_at
  ]
end

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

  module Author
    def add_fields
    end

    def remove_fields
    end

    def add_includes
    end

    def remove_includes
    end

    def status
    end
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

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :note, :born_at, :remember_me, :created_at, :updated_at
end

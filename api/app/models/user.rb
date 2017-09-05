class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true

  def gifts
    Gift.recipient_is(id)
  end

  def authored_gifts
    Gift.author_is(id)
  end

  def relationships
    Relationship.involving(self.id)
  end

  def friends
    friend_ids = relationships.approved.pluck(:user_one_id, :user_two_id).flatten
    friend_ids.delete(self.id)
    User.where(id: friend_ids)
  end
end

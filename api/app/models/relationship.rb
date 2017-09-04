class Relationship < ApplicationRecord
  belongs_to :user_one, class_name: "User"
  belongs_to :user_two, class_name: "User"
  belongs_to :action_user, class_name: "User"
  belongs_to :relation, required: false

  enum status: { pending: 0, approved: 1, declined: 2}

  validates_uniqueness_of :user_one_id, scope: :user_two_id
  validate :user_one_has_smaller_id

  scope :including_user, -> (user_id) { where(user_one_id: user_id).or(Relationship.where(user_two_id: user_id)) }

  def self.flexible_where(one, two)
    one = one.id if one.respond_to?(:id)
    two = two.id if two.respond_to?(:id)

    user_one = [one, two].min
    user_two = [one, two].max

    where(user_one_id: user_one, user_two_id: user_two)
  end

  # If user_one_id is always smaller than user_two_id, we always know how to look up the relationships for a given combination of users
  def user_one_has_smaller_id
    if user_one_id.to_i > user_two_id.to_i
      self.errors.add(:user_one_id, :user_one_id_larger, "user_one_id must be the smaller than user_two_id.")
    end
  end
end

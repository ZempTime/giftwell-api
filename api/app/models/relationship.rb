class Relationship < ApplicationRecord
  belongs_to :user_one
  belongs_to :user_two
  belongs_to :action_user # User who's performed the most recent status field update
  belongs_to :relation

  enum status: { pending: 0, accepted: 1, declined: 2, blocked: 3 }

  validates_uniqueness_of :user_one_id, scope: :user_two_id
  validate :user_one_has_smaller_id

  # If user_one_id is always smaller than user_two_id, we always know how to look up the relationships for a given combination of users
  def user_one_has_smaller_id
    if user_one_id.to_i > user_two_id.to_i
      self.errors.add(:user_one_id, :user_one_id_larger, "user_one_id must be the smaller than user_two_id.")
    end
  end
end

class Relationship < ApplicationRecord
  belongs_to :user_one
  belongs_to :user_two
  belongs_to :action_user
  belongs_to :relation

  enum status: { pending: 0, accepted: 1, declined: 2, blocked: 3 }
end

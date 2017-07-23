class Relationship < ApplicationRecord
  belongs_to :user_one
  belongs_to :user_two
  belongs_to :action_user
  belongs_to :relation
end

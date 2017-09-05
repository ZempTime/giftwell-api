class Gift < ApplicationRecord
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  belongs_to :author, class_name: 'User', foreign_key: :author_id, required: false

  enum status: { requested: 0, redeemed: 1, trashed: 2, error: 3 }

  scope :recipient_is,      -> (user_id) { where(recipient_id: user_id) }
  scope :recipient_is_not,  -> (user_id) { where.not(recipient_id: user_id) }
  scope :author_is,         -> (user_id) { where(author_id: user_id) }
  scope :author_is_not,     -> (user_id) { where.not(author_id: user_id) }

  PERMITTED_PARAMS = [
    :name,
    :note,
    :link,
    :position
  ]

  validates :name, presence: true
end

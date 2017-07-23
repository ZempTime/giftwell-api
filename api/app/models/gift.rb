class Gift < ApplicationRecord
  belongs_to :recipient, class_name: 'User'
  belongs_to :author, class_name: 'User'

  enum status: { requested: 0, redeemed: 1, trashed: 2, error: 3 }
end

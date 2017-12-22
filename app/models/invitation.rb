class Invitation < ApplicationRecord
  belongs_to :inviting_user, class_name: 'User'
end

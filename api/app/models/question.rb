class Question < ApplicationRecord
  belongs_to :recipient
  belongs_to :author_id
end

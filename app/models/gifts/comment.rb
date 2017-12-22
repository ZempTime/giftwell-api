module Gifts
  class Comment < ApplicationRecord
    set_table_name 'gifts_comments'

    belongs_to :author_id, class_name: 'User'
  end
end

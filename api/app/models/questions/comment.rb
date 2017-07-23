module Questions
  class Comment < ApplicationRecord
    set_table_name 'questions_comments'

    belongs_to :author_id
  end
end

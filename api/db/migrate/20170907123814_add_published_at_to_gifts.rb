class AddPublishedAtToGifts < ActiveRecord::Migration[5.1]
  def change
    add_column :gifts, :published_at, :datetime
  end
end

class CreateGiftsComments < ActiveRecord::Migration[5.1]
  def change
    create_table :gifts_comments do |t|
      t.references :author_id, foreign_key: { to_table: :users }, index: true
      t.references :gift_id, foreign_key: true, index: true
      t.string :note

      t.timestamps
    end
  end
end

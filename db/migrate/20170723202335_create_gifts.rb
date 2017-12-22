class CreateGifts < ActiveRecord::Migration[5.1]
  def change
    create_table :gifts do |t|
      t.string :name
      t.string :note
      t.string :link
      t.integer :position
      t.integer :status, default: 0
      t.references :recipient,  foreign_key: { to_table: :users }, index: true, on_delete: :cascade
      t.references :author,     foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end

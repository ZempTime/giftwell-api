class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :note
      t.boolean :answered, default: false
      t.references :recipient,  foreign_key: { to_table: :users }, index: true, on_delete: :cascade
      t.references :author,     foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end

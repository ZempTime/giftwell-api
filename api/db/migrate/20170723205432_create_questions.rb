class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :recipient, foreign_key: { to_table: :users }, index: true
      t.references :author, foreign_key: { to_table: :users }, index: true
      t.text :note
      t.boolean :answered, default: false

      t.timestamps
    end
  end
end

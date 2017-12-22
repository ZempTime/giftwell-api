class CreateQuestionsComments < ActiveRecord::Migration[5.1]
  def change
    create_table :questions_comments do |t|
      t.references :author, foreign_key: { to_table: :users }, index: true
      t.string :note

      t.timestamps
    end
  end
end

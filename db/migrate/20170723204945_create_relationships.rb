class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.references :user_one, foreign_key: { to_table: :users }, index: true
      t.references :user_two, foreign_key: { to_table: :users }, index: true
      t.integer :status, default: 0
      t.references :action_user, foreign_key: { to_table: :users }, index: true
      t.references :relation, foreign_key: true, index: true

      t.timestamps
    end
  end
end

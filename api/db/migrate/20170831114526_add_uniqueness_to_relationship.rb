class AddUniquenessToRelationship < ActiveRecord::Migration[5.1]
  def change
    add_index :relationships, [:user_one_id, :user_two_id], unique: true
  end
end

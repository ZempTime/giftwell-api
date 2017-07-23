class CreateRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :relations do |t|
      t.string :name

      t.timestamps
    end
  end
end

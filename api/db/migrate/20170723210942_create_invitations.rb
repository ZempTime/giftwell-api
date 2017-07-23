class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.datetime :expires_at
      t.string :token
      t.string :invite_capacity, default: 50
      t.references :inviting_user, foreign_key: {to_table: :users}, index: true

      t.timestamps
    end
  end
end

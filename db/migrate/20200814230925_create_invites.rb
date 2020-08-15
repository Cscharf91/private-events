class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.integer :inviter_id
      t.integer :invited_id
      t.references :event, foreign_key: true

      t.timestamps
    end
    add_index :invites, [:inviter_id, :invited_id]
  end
end

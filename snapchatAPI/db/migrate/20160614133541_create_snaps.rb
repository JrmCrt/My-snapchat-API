class CreateSnaps < ActiveRecord::Migration
  def change
    create_table :snaps do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :duration
      t.string :file

      t.timestamps null: false
    end
  end
end

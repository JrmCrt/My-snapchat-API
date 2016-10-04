class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :user_id1
      t.integer :user_id2
      t.boolean :accepted

      t.timestamps null: false
    end
  end
end

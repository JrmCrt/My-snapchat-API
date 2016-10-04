class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password
      t.string :email
      t.string :token

      t.timestamps null: false
    end
  end
end

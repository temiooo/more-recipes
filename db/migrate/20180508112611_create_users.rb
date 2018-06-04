class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :phone_number
      t.string :password_digest
      t.string :reset_password_token
      t.datetime :rest_password_expires

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :username
  end
end

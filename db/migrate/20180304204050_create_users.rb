class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.integer :phonenumber
      t.string :password
      t.string :resetPasswordToken
      t.datetime :resetpasswordExpires

      t.timestamps
    end
  end
end

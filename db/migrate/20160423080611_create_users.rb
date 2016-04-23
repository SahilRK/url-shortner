class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uname
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :api_token

      t.timestamps null: false
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false #6
      t.string :password_digest, null: false #6
      t.string :session_token, null: false #6

      t.timestamps null: false #6
    end

    add_index :users, :session_token, unique: true #7
    add_index :users, :username, unique: true #7
  end
end

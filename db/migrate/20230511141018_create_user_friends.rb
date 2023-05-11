# frozen_string_literal: true

class CreateUserFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :user_friends do |t|
      t.integer :user_id,        null: false, index: true
      t.integer :friend_user_id, null: false

      t.timestamps
    end

    add_foreign_key :user_friends, :users, column: :user_id
    add_foreign_key :user_friends, :users, column: :friend_user_id

    add_index :user_friends, %i[user_id friend_user_id], unique: true
  end
end

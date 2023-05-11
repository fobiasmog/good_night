class UserFriend < ApplicationRecord
  belongs_to :friend, foreign_key: :friend_user_id, class_name: 'User'
end

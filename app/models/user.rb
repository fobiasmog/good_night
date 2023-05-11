# frozen_string_literal: true
class User < ApplicationRecord
  self.per_page = 10

  validates :name, presence: true

  has_many :sleep_records
  has_many :user_friends
  has_many :friends, through: :user_friends, class_name: 'User'
end

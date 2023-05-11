class User < ApplicationRecord
  self.per_page = 10

  validates :name, presence: true

  has_many :sleep_records
end

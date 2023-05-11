class SleepRecord < ApplicationRecord
  self.per_page = 10

  validates :duration, comparison: { greater_than_or_equal_to: 0 }, if: -> { duration.present? }

  belongs_to :user

  scope :completed, ->() { where.not(duration: nil, stopped_at: nil) }
end

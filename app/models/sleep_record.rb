# frozen_string_literal: true
class SleepRecord < ApplicationRecord
  self.per_page = 10

  validates :duration, comparison: { greater_than_or_equal_to: 0 }, if: -> { duration.present? }

  belongs_to :user

  scope :completed, ->() { where.not(duration: nil, stopped_at: nil) }
  scope :stopped_on_previous_week, ->() {
    where(
      stopped_at: (
        (Time.now.beginning_of_week - 1.week) .. (Time.now.beginning_of_week - 1.week).end_of_week
      )
    )
  }
end

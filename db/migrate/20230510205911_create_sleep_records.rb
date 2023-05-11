# frozen_string_literal: true
class CreateSleepRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_records do |t|
      t.integer :duration
      t.belongs_to :user, foreign_key: true

      t.datetime :stopped_at, default: nil

      t.timestamps
    end

    add_check_constraint :sleep_records, 'duration >= 0 OR duration IS NULL', name: 'duration_check'
  end
end

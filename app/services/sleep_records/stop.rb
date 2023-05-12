# frozen_string_literal: true

module SleepRecords
  class Stop
    attr_reader :sleep_record

    def initialize(id)
      @sleep_record = SleepRecord.find(id)
    end

    def call
      sleep_record.update!(sleep_record_params)
    end

    private

    def sleep_record_params
      stopped_at = Time.now
      duration = (stopped_at - sleep_record.created_at).seconds.to_i

      {
        duration: duration,
        stopped_at: stopped_at
      }
    end
  end
end

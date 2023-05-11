# frozen_string_literal: true

module Api
  module V1
    class SleepRecordsController < ApplicationController
      before_action :set_sleep_record, only: %i[update]

      # GET /sleep_records
      def index
        @sleep_records = current_user.sleep_records.completed.order(created_at: :desc)

        render json: @sleep_records
      end

      # POST /sleep_records
      # new sleep record check-in
      def create
        clock_in_sleep_record = current_user.sleep_records.new

        if clock_in_sleep_record.save
          return head :created
        end

        render json: clock_in_sleep_record.errors, status: :unprocessable_entity
      end

      # PATCH/PUT /sleep_records/1
      # mark current sleep record as checked-in
      def update
        if @sleep_record.update(sleep_record_params)
          return render json: @sleep_record
        end

        render json: @sleep_record.errors, status: :unprocessable_entity
      end

      private

      def set_sleep_record
        @sleep_record ||= SleepRecord.find(params[:id])
      end

      def sleep_record_params
        stopped_at = Time.now
        duration = (stopped_at - @sleep_record.created_at).seconds.to_i

        {
          duration: duration,
          stopped_at: stopped_at
        }
      end
    end
  end
end

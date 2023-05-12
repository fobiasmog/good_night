# frozen_string_literal: true

module Api
  module V1
    class SleepRecordsController < ApplicationController
      # GET /sleep_records
      # list of sleep_records records
      def index
        sleep_records = current_user.sleep_records.order(created_at: :desc)

        render json: sleep_records
      end

      # POST /sleep_records
      # new sleep record check-in
      def create
        return head :accepted if current_user.sleep_records.active.present?

        head :created if current_user.sleep_records.create!
      end

      # PATCH/PUT /sleep_records/1
      # mark current sleep record as checked-in
      def update
        sleep_record = SleepRecords::Stop.new(params[:id]).call

        render json: sleep_record
      end
    end
  end
end

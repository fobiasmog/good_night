module Api
  module V1
    class UserFriendsController < ApplicationController
      rescue_from StandardError do |error|
        render json: { error: error }, status: :unprocessable_entity
      end

      # GET /friends
      def index
        render json: current_user.friends
      end

      # POST /friends
      def create
        UserFriend.create!(user_id: current_user.id, friend_user_id: params[:user_id])

        head :created
      end

      # DELETE /friends/1
      def destroy
        current_user.friends.where(friend_user_id: params[:id]).destroy

        head :no_content
      end

      # GET /friends/sleep_records
      # sleep records of a user's All friends from the previous week
      # which are sorted based on the duration of All friends sleep
      def sleep_records
        sleep_records = SleepRecord.where(
                                      user_id: current_user.friend_ids,
                                      'created_at >=': Time.now - 1.week
                                    )
                                    .order(duration: :desc)

        render json: sleep_records
      end
    end
  end
end

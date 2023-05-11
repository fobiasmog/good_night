class UserFriendsController < ApplicationController
  rescue_from ActiveRecord::RecordNotUnique do |error|
    render json: error, status: :unprocessable_entity
  end

  rescue_from StandardError do
    render json: { error: 'Oops, something went wrong' }, status: :unprocessable_entity
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
end

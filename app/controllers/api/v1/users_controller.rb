# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      # GET /users
      # show all possible friends
      def index
        @users = User.where.not(id: current_user.id).paginate(page: params[:page])

        render json: @users
      end
    end
  end
end

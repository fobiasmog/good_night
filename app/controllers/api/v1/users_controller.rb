# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      # GET /users
      def index
        @users = User.paginate(page: params[:page])

        render json: @users
      end
    end
  end
end

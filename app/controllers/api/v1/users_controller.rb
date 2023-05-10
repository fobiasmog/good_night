# frozen_string_literal: true

module Api
  module V1
    class Api::V1::UsersController < ApplicationController
      # GET /users
      def index
        @users = User.paginate(page: params[:page])

        render json: @users
      end
    end
  end
end

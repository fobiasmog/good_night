# frozen_string_literal: true

module Api
  module V1
    class Api::V1::UsersController < ApplicationController
      PER_PAGE = 10

      # GET /users
      def index
        @users = User.limit(PER_PAGE).offset(current_page * PER_PAGE)

        render json: @users
      end

      private

      # Only allow a list of trusted parameters through.
      def current_page
        params[:page] || 1
      end
    end
  end
end

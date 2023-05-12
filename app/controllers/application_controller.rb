# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :current_user

  rescue_from StandardError do |error|
    render json: { error: error }, status: :unprocessable_entity
  end

  private

  def current_user
    @current_user = User.find(params[:auth_user_id])
  end
end

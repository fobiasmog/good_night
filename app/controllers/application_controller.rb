class ApplicationController < ActionController::API
  before_action :current_user

  private def current_user
    @current_user = User.find(params[:auth_user_id])
  end
end

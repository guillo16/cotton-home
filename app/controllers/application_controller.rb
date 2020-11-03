class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def user_has_permission_level?
    current_user.permission_level == "admin" || current_user.permission_level == "super_admin"
  end
end

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include CurrentCart
  before_action :set_cart
  before_action :set_categories

  private

  def user_has_permission_level?
    current_user.permission_level == "admin" || current_user.permission_level == "super_admin"
  end

  def set_categories
    @categories = Category.all
  end
end

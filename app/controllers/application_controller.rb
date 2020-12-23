class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include CurrentCart
  before_action :set_cart
  before_action :set_categories
  after_action :store_action
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def user_has_permission_level?
    current_user.permission_level == "admin" || current_user.permission_level == "super_admin"
  end

  def set_categories
    @categories = Category.order(name: :asc)
  end

  def store_action
    return unless request.get?

    if (request.path != "/users/sign_in" &&
      request.path != "/users/sign_up" &&
      request.path != "/users/password/new" &&
      request.path != "/users/password/edit" &&
      request.path != "/users/confirmation" &&
      request.path != "/users/sign_out" &&
      !request.xhr?) # don't store ajax calls
      store_location_for(:user, request.fullpath)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :address, :phone, :state, :zip_code, :city])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :address, :city, :phone, :state, :zip_code])
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
end

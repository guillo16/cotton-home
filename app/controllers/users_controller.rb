class UsersController < ApplicationController
  def index
    if user_has_permission_level?
      @users = User.order(email: :asc).paginate(page: params[:page], per_page: 30)
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
    @products = Product.all
  end
end

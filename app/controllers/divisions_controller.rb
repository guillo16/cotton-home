class DivisionsController < ApplicationController
  def index
    if user_has_permission_level?
      @divisions = Division.all
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def show
    if user_is_wholesaler?
      @division = Division.find(params[:id])
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def edit
  end

  def new
  end
end

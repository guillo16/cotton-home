class DivisionsController < ApplicationController
  before_action :set_division, only: %i[update destroy]

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
      @division = Division.friendly.find(params[:id])
      @divisions = Division.all
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def new
    if user_has_permission_level?
      @division = Division.new
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def create
    @division = Division.new(division_params)
    if @division.save
      redirect_to division_path(@division)
    else
      render :new
    end
  end

  def edit
    if user_has_permission_level?
      @division = Division.friendly.find(params[:id])
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def update
    if @division.update(division_params)
      redirect_to division_path(@division)
    else
      render :edit
    end
  end

  def destroy
    return unless current_user.permission_level == "super_admin"

    @division.destroy
    redirect_to root_path
  end

  private

  def division_params
    params.require(:division).permit(:name)
  end

  def set_division
    @division = Division.friendly.find(params[:id])
  end
end

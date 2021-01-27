class DimensionsController < ApplicationController
  before_action :set_dimension, only: %i[show edit update destroy]
  before_action :set_article, only: %i[new create]
  def show; end

  def new
    if user_has_permission_level?
      @dimension = Dimension.new
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def create
    @dimension = Dimension.new(dimension_params)
    @dimension.article = @article
    if @dimension.save
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @dimension.update(dimension_params)
      redirect_to dimension_path(@dimension)
    else
      render :edit
    end
  end

  def destroy
    @dimension.destroy
    redirect_to article_path(@dimension.article)
  end

  private

  def set_article
    @article = Article.friendly.find(params[:article_id])
  end

  def set_dimension
    if user_has_permission_level?
      @dimension = Dimension.find(params[:id])
    else
      redirect_to root_path
    end
  end

  def dimension_params
    params.require(:dimension).permit(:size, :price, :description, :clarification)
  end
end

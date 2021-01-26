class ArticlesController < ApplicationController
  before_action :set_articles, only: %i[update destroy]

  def index
    if user_is_wholesaler?
      @articles = Article.includes(:division).order(division_id: :asc).order(name: :asc).paginate(page: params[:page], per_page: 20)
      @divisions = Division.all
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def show
    if user_is_wholesaler?
      @article = Article.friendly.find(params[:id])
      @articles = Article.all
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def new
    if user_has_permission_level?
      @article = Article.new
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def edit
    if user_has_permission_level?
      @article = Article.friendly.find(params[:id])
    else
      flash[:notice] = "Accesso denegado!"
      redirect_to root_path
    end
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    return unless current_user.permission_level == "admin"

    @article.destroy
    redirect_to articles_path
  end

  private

  def set_articles
    @article = Article.friendly.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:name, :division_id, photos: [])
  end
end

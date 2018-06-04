class RecipesController < ApplicationController
  before_action :require_user

  def index
    @category_recipes = Recipe.where(category_id: params[:category_id])
    @category_name = Category.find(params[:category_id]).name
  end

  def new
    @recipe = Recipe.new
  end

  def create
    binding.pry
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = "New recipe added"
      redirect_to my_recipes_path
    else
      flash[:error] = @recipe.errors.full_messages[0]
      redirect_to my_recipes_path
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    render json: @recipe
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:notice] = "Recipe updated successfully"
      redirect_to my_recipes_path
    else
      flash[:error] = @recipe.errors.full_messages[0]
      redirect_to my_recipes_path
    end
  end

  def destroy
    Recipe.destroy(params[:id])
    flash[:notice] = "Recipe deleted"
    redirect_to my_recipes_path
  end

  def my_recipes
    @my_recipes = current_user.recipes
  end

  def all_recipes
    @recipes = Recipes.all
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :name,
      :user_id,
      :category_id,
      :description,
      :recipe_image,
      :ingredients => [],
      :method => []
    )
  end
end

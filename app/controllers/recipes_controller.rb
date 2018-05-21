class RecipesController < ApplicationController
  before_action :require_user

  def index
    @category_recipes = Recipe.where(category_id: params[:category_id])
    @category_name = Category.find(params[:category_id]).name
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save!
      flash[:notice] = "New recipe added"
      redirect_to my_recipes_path
    else
      flash[:error] = @recipe.errors.full_messages[0]
      redirect_to my_recipes_path
    end
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

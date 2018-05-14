class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
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

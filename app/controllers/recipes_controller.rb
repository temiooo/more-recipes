class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def create
    binding.pry
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = "New recipe added"
      redirect_to categories_path
    else
      flash[:error] = @user.errors.full_messages[0]
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
      :ingredients,
      :method,
      :recipe_image
    )
  end
end

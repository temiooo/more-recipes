class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def create
    
  end

  def my_recipes
    # @my_recipes = Recipe.where(user_id: current_user.id)
  end


end

class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category_recipes = Recipe.where(category_id: params[:id])
    binding.pry
  end
end
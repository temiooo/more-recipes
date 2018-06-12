class FavouritesController < ApplicationController
  def favourite
    @favourite = Favourite.new(built_params)
    if @favourite.save
      render json: { status: "success" }
    else
      render json: { status: "failure" }
    end
  end

  def unfavourite
    @favourite = Favourite.existing(current_user.id, params[:recipe_id])
    if @favourite.destroy_all
      render json: { status: "success" }
    else
      render json: { status: "failure" }
    end
  end

  def built_params
    { 
      user_id: current_user.id,
      favourite_status: true,
      recipe_id: params[:recipe_id]
    }
  end

  def favourite_params
    params.permit(
      :recipe_id
    )
  end
end

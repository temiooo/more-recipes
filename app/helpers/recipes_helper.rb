module RecipesHelper
  def get_current_image
    image_id = @recipe.recipe_image.file.public_id
  end
  def delete_previous_image(image_id)
    Cloudinary::Uploader.destroy(image_id)
  end
end

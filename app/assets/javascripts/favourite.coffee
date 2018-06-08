# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Favourite.App
  constructor: ->
    @handleRecipeFavourite()

  favouriteRecipe: (recipeId) =>
    return $.ajax(
      url: "/recipe/favourite"
      type: 'POST' 
      data: recipeId
      success: (data) ->
        return data
    )

  unfavouriteRecipe: (recipeId) =>
    return $.ajax(
      url: "/recipe/unfavourite"
      type: 'DELETE' 
      data: recipeId
      success: (data) ->
        return data
    )

  handleRecipeFavourite: =>
    self = @
    $("span.fav i").on "click", ->
      favouriteStatus = $(this).attr("data-value")
      details = {
        recipe_id: $(this).data("recipe-id")
      }

      if favouriteStatus == "true"
        self.unfavouriteRecipe(details).then((response) =>
          if response.status == "success"
            $(this).attr("data-value", "false")
            $(this).css({"color": "#808080", "animation": "favourite 0.5s ease-out"})
            location.reload()
          else
            # TODO - SEND UNSUCESSFUL ACTION TOAST MESSAGE
        )

      else
        self.favouriteRecipe(details).then((response) =>
          if response.status == "success"
            $(this).attr("data-value", "true")
            $(this).css({"color": "#ff0000", "animation": "favourite 0.5s ease-in"})
            location.reload()
          else
            # TODO - SEND UNSUCESSFUL ACTION TOAST MESSAGE
        )

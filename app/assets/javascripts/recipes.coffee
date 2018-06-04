# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Recipe.App
  constructor: ->
    @clearFormFields()
    @handleEditRecipe()
    @validateFormFields()
    @submitRecipeForm()
    @handleArrayInput("method", "#add-recipe-form")
    @handleArrayInput("method", "#edit-recipe-form")
    @disableDefaultFormSubmission()
    @handleArrayInput("ingredient", "#add-recipe-form")
    @handleArrayInput("ingredient", "#edit-recipe-form")
    @showArrayInputCursor("method")
    @showArrayInputCursor("ingredient")
    @recipeId = ''
    @recipeData = new FormData()

  clearFormFields: =>
    $(".recipe-form-close").on "click", ->
      $("input#recipe-name").val("")
      $("select.category-select").val(null)
      $("textarea#recipe-description").val("")
      $("input.ingredient-input").val("")
      $("input.ingredient-input").siblings().remove()
      $("input.method-input").val("")
      $("input.method-input").siblings().remove()
      $('input#recipe-image').val("")
      $("label.error").remove()

  getInputTextWidth: (text) =>
    textInSpan = "<span id='text-width' style='display:none;'>#{text}</span>"
    $(".navbar").after textInSpan
    inputTextWidth = $('#text-width').width()
    $('#text-width').remove()
    return inputTextWidth

  disableDefaultFormSubmission: =>
    $(document).on 'keypress', 'form', (event) ->
      if event.keyCode == 13
        event.preventDefault()
        return false

  showArrayInputCursor: (type) =>
    $(".#{type}-wrapper").on "click", ->
      $(".#{type}-input").focus()

  handleArrayInput: (type, formName) =>
    itemNumber = 1

    $("#{formName} .#{type}-input").on "keydown", (event) =>
      if event.keyCode == 13
        itemValue = $("#{formName} .#{type}-input").val().trim()

        console.log "help at this point", type, itemValue
        if itemValue.length > 0
          inputWidth = @getInputTextWidth(itemValue) + 10

          if type == "ingredient"
            $("#{formName} .#{type}-input").before """
              <div id="#{type}-item-#{itemNumber}">
                <input type=text name=recipe[#{type}s][] value="#{itemValue}"  style="width: #{inputWidth}px;" readonly/>
                <i class="icon ion-close"></i>
              </div>      
            """

          if type == "method"
            $("#{formName} .#{type}-input").before """
              <div id="#{type}-item-#{itemNumber}">
                <input type=text name=recipe[#{type}][] value="#{itemValue}"  style="width: #{inputWidth}px;" readonly/>
                <i class="icon ion-close"></i>
              </div>      
            """

          $("#{formName} .#{type}-wrapper").scrollTop($(".#{type}-wrapper").prop('scrollHeight'))

          $("#{formName} .#{type}-input").val("")

          $("#{formName} ##{type}-item-#{itemNumber} > .icon").on "click", ->
            $(this).parent().remove()
          itemNumber += 1

  validateFormFields: =>
    $.validator.addMethod 'require-array', ((value, element) ->
      itemCount = $(element).parent().find("div").length
      if itemCount > 0
        return true
      return false
    ), $.validator.messages.required

    $.validator.addMethod 'enforce-empty-input-on-save', ((value) ->
      if value.length == 0
        return true
      return false
    ), "Press enter to add the input field value to the list"

    $.validator.addMethod 'noonlywhitespace', ((value) ->
      if value.trim().length == 0
        return false
      return true
    ), "No white space please"

    $("#add-recipe-form").validate
      focusInvalid: false
      ignore: []
      rules:
        "recipe[name]":
          "required": true
          "noonlywhitespace": true
        "recipe[category_id]": "required"
        "recipe[description]":
          "required": true
          "noonlywhitespace": true
        "recipe[ingredient_input]":
          "require-array": true
          "enforce-empty-input-on-save": true
        "recipe[method_input]":
          "require-array": true
          "enforce-empty-input-on-save": true
        "recipe[recipe_image]": "required"

      errorPlacement: (error, element) ->
        if element.attr('name') == 'recipe[ingredient_input]'
          error.insertAfter("#add-recipe-form .ingredient-wrapper")
        else if element.attr('name') == 'recipe[method_input]'
          error.insertAfter("#add-recipe-form .method-wrapper")
        else
          error.insertAfter(element)

  getRecipeDetails: (id) =>
    return $.ajax(
      url: "/recipes/#{id}/edit"
      type: 'GET'
      success: (data) ->
        return data
    )

  populateArrayField: (type, items) =>
    $.each(items, (index, itemValue) =>
      inputWidth = @getInputTextWidth(itemValue) + 10
      
      if type == "ingredient"
        $(".#{type}-input").before """
          <div id="#{type}-item#{index}">
            <input type=text name=recipe[#{type}s][] value="#{itemValue}"  style="width: #{inputWidth}px;" readonly/>
            <i class="icon ion-close"></i>
          </div>      
        """

      if type == "method"
        $(".#{type}-input").before """
          <div id="#{type}-item#{index}">
            <input type=text name=recipe[#{type}][] value="#{itemValue}"  style="width: #{inputWidth}px;" readonly/>
            <i class="icon ion-close"></i>
          </div>      
        """

      $("##{type}-item#{index} > .icon").on "click", ->
        $(this).parent().remove()
    )

  
  populateRecipeEditFrom: (details) =>
    $("input[name=name]").val(details.name)
    $("select[name=category_id]").val(details.category_id)
    $("textarea[name=description").val(details.description)
    @populateArrayField("ingredient", details.ingredients)
    @populateArrayField("method", details.method)

  handleEditRecipe: =>
    self = @
    $('.recipe-edit').on "click", ->
      self.recipeId = $(this).attr("data-value")
      self.getRecipeDetails(self.recipeId).then(
        self.populateRecipeEditFrom
      )
  
  saveRecipeForm: (id, details) =>
    return $.ajax(
      url: "/recipes/#{id}"
      type: 'PUT' 
      data: details
      cache: false
      processData: false
      contentType: false
    )

  getRecipeParameters: =>
    self = @

    name = $("#edit-recipe-form #recipe-name").val()
    self.recipeData.append("recipe[name]", name)

    category_id = $("#edit-recipe-form .category-select").val()
    self.recipeData.append("recipe[category_id]", category_id)

    description = $("#edit-recipe-form #recipe-description").val()
    self.recipeData.append("recipe[description]", description)

    ingredients =  $("#edit-recipe-form input[name='recipe[ingredients][]']").map( ->@value )
    for ingredient in ingredients
      self.recipeData.append("recipe[ingredients][]", ingredient)

    method = $("#edit-recipe-form input[name='recipe[method][]']").map( ->@value )
    for item in method
      self.recipeData.append("recipe[method][]", item)
    
    recipeImage = $("#edit-recipe-form input#recipe-image")[0].files[0]
    if recipeImage
      self.recipeData.append("recipe[recipe_image]", recipeImage)

  submitRecipeForm: =>
    self = @
    $("#edit-recipe-form .save-recipe").on "click", ->
      self.getRecipeParameters()
      self.saveRecipeForm(self.recipeId, self.recipeData)

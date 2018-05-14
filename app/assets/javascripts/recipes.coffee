# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Recipe.App
  constructor: ->
    @handleArrayInput("method")
    @disableDefaultFormSubmission()
    @handleArrayInput("ingredient")
    @showArrayInputCursor("method")
    @showArrayInputCursor("ingredient")
    @validateFormFields()

  getInputTextWidth: (text, element) =>
    textInSpan = "<span class='text-width' style='display:none;'>#{text}</span>"
    $(element).after textInSpan
    inputTextWidth = $('.text-width').width()
    $('.text-width').remove()
    return inputTextWidth

  disableDefaultFormSubmission: =>
    $(document).on 'keypress', 'form', (event) ->
      if event.keyCode == 13
        event.preventDefault()
        return false

  showArrayInputCursor: (type) =>
    $(".#{type}-wrapper").on "click", ->
      if $(".#{type}-wrapper").children().length == 1
        $(".#{type}-input").focus()

  handleArrayInput: (type) =>
    itemNumber = 1

    $(".#{type}-input").on "keydown", (event) =>
      if event.keyCode == 13
        itemValue = $(".#{type}-input").val().trim()

        if itemValue.length > 0
          inputWidth = @getInputTextWidth(itemValue, ".#{type}-input") + 10

          if type == "ingredient"
            $(".#{type}-input").before """
              <div id="#{type}-item-#{itemNumber}">
                <input type=text name=recipe[#{type}s][] value="#{itemValue}"  style="width: #{inputWidth}px;" readonly/>
                <i class="icon ion-close"></i>
              </div>      
            """

          if type == "method"
            $(".#{type}-input").before """
              <div id="#{type}-item-#{itemNumber}">
                <input type=text name=recipe[#{type}][] value="#{itemValue}"  style="width: #{inputWidth}px;" readonly/>
                <i class="icon ion-close"></i>
              </div>      
            """

          $(".#{type}-wrapper").scrollTop($(".#{type}-wrapper").prop('scrollHeight'))

          $(".#{type}-input").val("")

          $("##{type}-item-#{itemNumber} > .icon").on "click", ->
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

    $("#add-recipe-form").validate
      focusInvalid: false
      ignore: []
      rules:
        "recipe[name]": "required"
        "recipe[category_id]": "required"
        "recipe[description]": "required"
        "recipe[ingredient_input]":
          "require-array": true
          "enforce-empty-input-on-save": true
        "recipe[method_input]":
          "require-array": true
          "enforce-empty-input-on-save": true
        "recipe[recipe_image]": "required"

      errorPlacement: (error, element) ->
        if element.attr('name') == 'recipe[ingredient_input]'
          error.insertAfter(".ingredient-wrapper")
        else if element.attr('name') == 'recipe[method_input]'
          error.insertAfter(".method-wrapper")
        else
          error.insertAfter(element)

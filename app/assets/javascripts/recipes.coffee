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
        itemValue = $(".#{type}-input").val()

        if itemValue.trim().length > 0
          inputWidth = @getInputTextWidth(itemValue, ".#{type}-input") + 10

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

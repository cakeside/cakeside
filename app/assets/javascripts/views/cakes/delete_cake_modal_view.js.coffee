class CakeSide.Views.Cakes.DeleteCakeModalView extends Marionette.ItemView
  template: JST["templates/cakes/delete_modal"]
  ui:
    remove_button: "#remove-button"
    confirmation_textbox: '#confirmation-textbox'

  templateHelpers:
    hasError: ->
      typeof(@errorMessage) != "undefined"

  events:
    "click #remove-button": "remove"
    'keyup #confirmation-textbox': 'refreshStatus'

  modelEvents:
    'change:errorMessage':'render'

  remove: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @model.unset('errorMessage')
    @model.destroy(success: @successfullyDeleted, error: @errorDeletingCake)

  successfullyDeleted: =>
    @closeDialog()
    window.location.hash = "cakes"

  errorDeletingCake: (model, response, options) ->
    model.set('errorMessage', 'Could not delete cake.')

  refreshStatus: ->
    if @ui.confirmation_textbox.val() == @model.get('name')
      @ui.remove_button.removeAttr('disabled')
    else
      @ui.remove_button.attr('disabled', 'disabled')

  closeDialog: (photo) ->
    $('#modal').modal('hide')

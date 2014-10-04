CakeSide.Views.Profiles ||= {}

class CakeSide.Views.Profiles.ShowView extends Marionette.ItemView
  template: JST["backbone/templates/profiles/show"]
  ui:
    name: '#user_name'
    email: '#user_email'
    city: '#user_city'
    website: '#user_website'
    facebook: '#user_facebook'
    twitter: '#user_twitter'
    save_button: '#save-button'

  modelEvents:
    'invalid': 'displayError'

  events:
    "submit #profile-form": "save"
    "keyup input": "refreshStatus"
    "change select": "refreshStatus"

  save: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @disableSaveButton()
    @model.save()

  enableSaveButton: ->
    @ui.save_button.removeAttr('disabled')

  disableSaveButton: ->
    @ui.save_button.attr('disabled', 'disabled')

  displayError: ->
    @disableSaveButton()

  refreshStatus: ->
    @enableSaveButton()
    @model.set('name', @ui.name.val())
    @model.set('email', @ui.email.val())
    @model.set('city', @ui.city.val())
    @model.set('website', @ui.website.val())
    @model.set('facebook', @ui.facebook.val())
    @model.set('twitter', @ui.twitter.val())
    @model.isValid()


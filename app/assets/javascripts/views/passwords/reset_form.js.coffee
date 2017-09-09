class csx.Views.PasswordResetForm extends csx.FormView
  @viewName 'password-reset-form'
  modelKey: "user"
  events:
    'input #user_email': 'onInput'
    'submit form': 'onSubmit'

  initialize: () ->
    @model = new csx.Models.PasswordReset()

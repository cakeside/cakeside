#= require views/auto_view

class csx.Views.RegistrationForm extends csx.FormView
  @viewName 'registration-form'
  modelKey: "user"
  events:
    'input #user_name': 'onInput'
    'input #user_email': 'onInput'
    'input #user_password': 'onInput'
    'change #user_accepted': 'onInput'
    'submit form': 'onSubmit'

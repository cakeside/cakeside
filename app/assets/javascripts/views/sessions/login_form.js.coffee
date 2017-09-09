#= require views/auto_view

class csx.Views.LoginForm extends csx.FormView
  @viewName 'login-form'
  modelKey: "session"
  events:
    'input #session_email': 'onInput'
    'input #session_password': 'onInput'
    'submit form': 'onSubmit'

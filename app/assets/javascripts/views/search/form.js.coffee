class csx.Views.SearchForm extends csx.FormView
  @viewName 'search-form'
  events:
    'input #q': 'onInput'
    'submit form': 'onSubmit'

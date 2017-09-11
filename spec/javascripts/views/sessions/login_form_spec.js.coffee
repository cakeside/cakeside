describe "csx.Views.LoginForm", ->
  subject = null

  beforeEach ->
    fixture.set '''
<div data-autoview="login-form">
  <form class="form-horizontal" data-autoview="login-form" id="new_user_session" action="/sessions" accept-charset="UTF-8" method="post">
    <input name="utf8" type="hidden" value="✓">
    <input type="hidden" name="authenticity_token" value="NUk9vz3sVMzi09PgQrzOTDcJIki2RgCzHgtpFw0ooSha4lgMt/bUsuAk//Wvi7wb/K6qh+pVrDkKr5a5e66QTw==">
    <div class="form-group">
      <input type="email" name="session[email]" id="session_email" value="" placeholder="Email" class="form-control" required="required">
      <div class="invalid-feedback"></div>
    </div>
    <div class="form-group">
      <input type="password" name="session[password]" id="session_password" value="" placeholder="Password" class="form-control" required="required">
      <div class="invalid-feedback"></div>
    </div>
    <p><a href="/passwords/new">Forgot your password?</a></p>
    <input type="submit" name="commit" value="Sign In" class="btn btn-primary">
  </form>
</div>
'''

    subject = new csx.Views.LoginForm
      el: $('[data-autoview=login-form]')
      model: new csx.Models.Session()

  it "disables the submit button when the email is missing", ->
    subject.$('form').submit()

    expect(subject.$('input[type=submit]').prop('disabled')).toEqual(true)
    expect(subject.field('email').siblings('.invalid-feedback').html()).toEqual("Email can't be blank")

  it "disables the submit button when the password is missing", ->
    subject.field('email').val('user@email.com')
    subject.$('form').submit()

    expect(subject.$('input[type=submit]').prop('disabled')).toEqual(true)
    expect(subject.field("password").siblings('.invalid-feedback').html()).toEqual("Password can't be blank")

  it "enables the submit button when all required fields are specified", ->
    subject.field('email').val('user@email.com').change()
    subject.field('password').val('password').change()

    expect(subject.$('input[type=submit]').prop('disabled')).toEqual(false)
    expect(subject.field('email').siblings('.invalid-feedback').html()).toEqual('')
    expect(subject.field('password').siblings('.invalid-feedback').html()).toEqual('')

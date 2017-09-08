describe "CakeSide.Models.Session", ->
  subject = null

  beforeEach ->
    subject = new CakeSide.Models.Session()

  it "is invalid, when the email is missing", ->
    attributeName = I18n.t("activerecord.attributes.session.username")
    error = I18n.t("activerecord.errors.messages.blank")
    expectedError = "#{attributeName} #{error}"

    expect(subject.isValid()).toEqual(false)
    expect(subject.validationError['username']).toEqual(expectedError)

  it "is invalid, when the password is missing", ->
    attributeName = I18n.t("activerecord.attributes.session.password")
    error = I18n.t("activerecord.errors.messages.blank")
    expectedError = "#{attributeName} #{error}"

    expect(subject.isValid()).toEqual(false)
    expect(subject.validationError['password']).toEqual(expectedError)

  it "is valid", ->
    subject.set('username', 'x@example.com')
    subject.set('password', 'password')
    expect(subject.isValid()).toEqual(true)
    expect(subject.validationError).toEqual(null)

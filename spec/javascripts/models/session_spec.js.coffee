describe "csx.Models.Session", ->
  subject = null

  beforeEach ->
    subject = new csx.Models.Session()

  it "is invalid, when the email is missing", ->
    expectedError = "Email can't be blank"

    expect(subject.isValid()).toEqual(false)
    expect(subject.validationError['email']).toEqual(expectedError)

  it "is invalid, when the email is not a valid email addrees", ->
    subject.set('email', 'blah')
    expectedError = "Email is invalid"

    expect(subject.isValid()).toEqual(false)
    expect(subject.validationError['email']).toEqual(expectedError)

  it "is invalid, when the password is missing", ->
    expectedError = "Password can't be blank"

    expect(subject.isValid()).toEqual(false)
    expect(subject.validationError['password']).toEqual(expectedError)

  it "is valid", ->
    subject.set('email', 'test@example.com')
    subject.set('password', 'password')
    expect(subject.isValid()).toEqual(true)
    expect(subject.validationError).toEqual(null)

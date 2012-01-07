Factory.define :creation, :class => Creation do |c|
  include ActionDispatch::TestProcess
  c.name 'cake'
  c.story 'whats the story morning glory?'
  c.image fixture_file_upload("/files/example.jpg", "image/jpg")
end

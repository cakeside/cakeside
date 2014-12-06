require "rails_helper"


describe Tool do 
  
  it "has a name" do 
    tool = Tool.new 
    tool.name = "wilton pan"
    expect(tool.name).to eql("wilton pan")
  end

  it "has a description" do
    tool = Tool.new
    tool.description = "This pan can be used to make round cakes"
    expect(tool.description).to eql("This pan can be used to make round cakes")
  end

  it "has an ASIN" do
    tool = Tool.new
    tool.asin = "223455"
    expect(tool.asin).to eql("223455")
  end

  it "saves to the database" do
    tool = Tool.new
    tool.asin = "223455"
    tool.description = "This pan can be used to make round cakes"
    tool.name = "wilton pan"
    tool.save
    tool.reload
    expect(tool.name).to eql("wilton pan")
    expect(tool.description).to eql("This pan can be used to make round cakes")
    expect(tool.asin).to eql("223455")
  end

  context "#validation" do
    it "has to have a name" do
      tool = Tool.new
      expect(tool).to_not be_valid
      expect(tool.errors[:name]).to_not be_empty
    end

    it "name has to be unique" do 
      Tool.create(name: 'blah')

      tool = Tool.new(name: 'blah')
      tool.valid?
      expect(tool.errors[:name]).to_not be_empty
    end
  end
end

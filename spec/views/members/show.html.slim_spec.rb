require 'spec_helper'

describe "members/show" do
  before(:each) do
    @member = assign(:member, stub_model(Member,
      :name => "Name",
      :email => "Email",
      :college => "College",
      :year => "Year",
      :hometown => "Hometown",
      :major => "Major",
      :position => "Position",
      :fact => "Fact",
      :place => "Place"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Email/)
    rendered.should match(/College/)
    rendered.should match(/Year/)
    rendered.should match(/Hometown/)
    rendered.should match(/Major/)
    rendered.should match(/Position/)
    rendered.should match(/Fact/)
    rendered.should match(/Place/)
  end
end

require 'spec_helper'

describe "members/index" do
  before(:each) do
    assign(:members, [
      stub_model(Member,
        :name => "Name",
        :email => "Email",
        :college => "College",
        :year => "Year",
        :hometown => "Hometown",
        :major => "Major",
        :position => "Position",
        :fact => "Fact",
        :place => "Place"
      ),
      stub_model(Member,
        :name => "Name",
        :email => "Email",
        :college => "College",
        :year => "Year",
        :hometown => "Hometown",
        :major => "Major",
        :position => "Position",
        :fact => "Fact",
        :place => "Place"
      )
    ])
  end

  it "renders a list of members" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "College".to_s, :count => 2
    assert_select "tr>td", :text => "Year".to_s, :count => 2
    assert_select "tr>td", :text => "Hometown".to_s, :count => 2
    assert_select "tr>td", :text => "Major".to_s, :count => 2
    assert_select "tr>td", :text => "Position".to_s, :count => 2
    assert_select "tr>td", :text => "Fact".to_s, :count => 2
    assert_select "tr>td", :text => "Place".to_s, :count => 2
  end
end

require 'spec_helper'

describe "members/new" do
  before(:each) do
    assign(:member, stub_model(Member,
      :name => "MyString",
      :email => "MyString",
      :college => "MyString",
      :year => "MyString",
      :hometown => "MyString",
      :major => "MyString",
      :position => "MyString",
      :fact => "MyString",
      :place => "MyString"
    ).as_new_record)
  end

  it "renders new member form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", members_path, "post" do
      assert_select "input#member_name[name=?]", "member[name]"
      assert_select "input#member_email[name=?]", "member[email]"
      assert_select "input#member_college[name=?]", "member[college]"
      assert_select "input#member_year[name=?]", "member[year]"
      assert_select "input#member_hometown[name=?]", "member[hometown]"
      assert_select "input#member_major[name=?]", "member[major]"
      assert_select "input#member_position[name=?]", "member[position]"
      assert_select "input#member_fact[name=?]", "member[fact]"
      assert_select "input#member_place[name=?]", "member[place]"
    end
  end
end

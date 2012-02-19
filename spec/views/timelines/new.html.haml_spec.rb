require 'spec_helper'

describe "timelines/new" do
  before(:each) do
    assign(:timeline, stub_model(Timeline,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new timeline form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => timelines_path, :method => "post" do
      assert_select "input#timeline_name", :name => "timeline[name]"
    end
  end
end

require 'spec_helper'

describe "timelines/index" do
  before(:each) do
    assign(:timelines, [
      stub_model(Timeline,
        :name => "Name"
      ),
      stub_model(Timeline,
        :name => "Name"
      )
    ])
  end

  it "renders a list of timelines" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end

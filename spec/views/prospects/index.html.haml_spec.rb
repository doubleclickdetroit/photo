require 'spec_helper'

describe "prospects/index" do
  before(:each) do
    assign(:prospects, [
      stub_model(Prospect,
        :first => "First",
        :last => "Last",
        :state => "State",
        :email => "Email",
        :heard_from => "Heard From"
      ),
      stub_model(Prospect,
        :first => "First",
        :last => "Last",
        :state => "State",
        :email => "Email",
        :heard_from => "Heard From"
      )
    ])
  end

  it "renders a list of prospects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "First".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Last".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Heard From".to_s, :count => 2
  end
end

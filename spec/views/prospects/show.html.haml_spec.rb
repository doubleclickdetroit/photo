require 'spec_helper'

describe "prospects/show" do
  before(:each) do
    @prospect = assign(:prospect, stub_model(Prospect,
      :first => "First",
      :last => "Last",
      :state => "State",
      :email => "Email",
      :heard_from => "Heard From"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/First/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Last/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/State/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Heard From/)
  end
end

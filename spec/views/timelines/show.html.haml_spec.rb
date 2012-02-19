require 'spec_helper'

describe "timelines/show" do
  before(:each) do
    @timeline = assign(:timeline, stub_model(Timeline,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end

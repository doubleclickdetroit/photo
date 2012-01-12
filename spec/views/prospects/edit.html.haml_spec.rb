# require 'spec_helper'
# 
# describe "prospects/edit" do
#   before(:each) do
#     @prospect = assign(:prospect, stub_model(Prospect,
#       :first => "MyString",
#       :last => "MyString",
#       :state => "MyString",
#       :email => "MyString",
#       :heard_from => "MyString"
#     ))
#   end
# 
#   it "renders the edit prospect form" do
#     render
# 
#     # Run the generator again with the --webrat flag if you want to use webrat matchers
#     assert_select "form", :action => prospects_path(@prospect), :method => "post" do
#       assert_select "input#prospect_first", :name => "prospect[first]"
#       assert_select "input#prospect_last", :name => "prospect[last]"
#       assert_select "input#prospect_state", :name => "prospect[state]"
#       assert_select "input#prospect_email", :name => "prospect[email]"
#       assert_select "input#prospect_heard_from", :name => "prospect[heard_from]"
#     end
#   end
# end

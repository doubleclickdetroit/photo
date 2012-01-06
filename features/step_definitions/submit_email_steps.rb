Given /^my email address is "([^""]*)"$/ do |arg1|
  @prospect  = Prospect.new :first => 'Brad', :last => 'Chase',
                        :state => 'OH', :email => 'foo@bar.com',
                        :newsletter => true, :heard_from => 'Other'
end

Given /^I have never submitted it before$/ do
  Prospect.where(:email => @prospect.email).each(&:destroy)
end

Given /^I have submitted it before$/ do
  @prospect.save
end

When /^I visit the teaser page$/ do
  visit root_path
end

When /^submit my email address and info$/ do
  fill_in "First", :with => @prospect.first
  fill_in "Last", :with => @prospect.last
  fill_in "State", :with => @prospect.state
  fill_in "Email", :with => @prospect.email
  select @prospect.heard_from, :from => 'prospect_heard_from'
  check "newsletter" if @prospect.newsletter
  click_button "Save"
end

Then /^I am greeted with a thank you message$/ do
  page.should have_content("Thank you!")
end

Then /^my information is saved$/ do
  Prospect.last == @prospect
end

Then /^my information is not saved twice$/ do
  Prospect.where(:email => @prospect.email).count == 1
end

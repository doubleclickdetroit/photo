Given /^I belong to a group$/ do
  @group = Factory(:group)
end

Given /^I am an admin for that group$/ do
  @user.enroll_in(@group, :as => :admin)
end

Given /^I am an owner for that group$/ do
  @user.enroll_in(@group, :as => :owner)
end

When /^I visit that group's profile$/ do
  visit group_path(@group)
end

When /^click 'New Timeline'$/ do
  click_link 'New Timeline'
end

When /^I fill in "([^""]*)" with "([^""]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end


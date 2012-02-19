Given /^there are many groups I do not belong to$/ do
  5.times { Factory.create(:group) }
end

Given /^I am logged in$/ do
  @user = Factory(:user)

  visit root_path
  click_link 'Login'

  fill_in 'Email', :with => @user.email
  fill_in 'Password', :with => @user.password
  click_button 'Sign in'
end

When /^I navigate to group management$/ do
  visit groups_path
end

When /^I click the link "([^"]*)"$/ do |link|
  click_link link
end

When /^fill in "([^"]*)" with "([^"]*)"$/ do |field, val|
  fill_in field, :with => val
end

When /^click the button "([^"]*)"$/ do |button|
  click_button button
end

Then /^I should see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

Then /^I should be the owner of the group$/ do
  # # todo
  page.should have_content('Owner')

  @user.has_role?(:owner, :for => Group.last).should be_true
end

Then /^I should see no groups$/ do
  page.should_not have_css('tr.group')
end

Then /^there should be only one group on the page with the name "([^"]*)"$/ do |name|
  page.should have_css('tr.group', :count => 1)
  # todo
  page.should have_content(name)
end

Given /^I am not logged in$/ do
  delete destroy_user_session_url
end

# Then /^I am redirected to "([^\"]*)"$/ do |url|
#   assert [301, 302].include?(@integration_session.status), "Expected status to be 301 or 302, got #{@integration_session.status}"
#   location = @integration_session.headers["Location"]
#   assert_equal url, location
#   visit location
# end

# Inviting an individual to join my group via email
# Given /^I am logged in and the owner of the group$/ do
#   @user = Factory(:user)
# end
# 
# Given /^fill in the email field$/ do
#   pending # express the regexp above with the code you wish you had
# end
# 
# Given /^click the button "([^"]*)"$/ do |arg1|
#   pending # express the regexp above with the code you wish you had
# end
# 
# When /^I visit the profile of the user I wish to add$/ do
#   pending # express the regexp above with the code you wish you had
# end
# 
# When /^I click the button "([^"]*)"$/ do |arg1|
#   pending # express the regexp above with the code you wish you had
# end
# 
# Then /^they should receive an email$/ do
#   pending # express the regexp above with the code you wish you had
# end

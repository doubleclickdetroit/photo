Given /^I am a guest to the site$/ do
  delete destroy_user_session_path
end

When /^I visit a specific user's profile$/ do
  @user = Factory(:user)
  visit "/profile/#{@user.name}"
end

Then /^I should see their personal information$/ do
  page.should have_content(@user.name)
  page.should have_content(@user.email)
  # page.should have_content(@user.first)
  # page.should have_content(@user.last)
end


# Given /^I have the following information$/ do |user|
#   @user = user.hashes.first
# end
# 
# Given /^I am not a registered user$/ do
#   User.destroy_all
# end
# 
# When /^I visit the home page$/ do
#   visit root_path
# end
# 
# When /^click "([^"]*)"$/ do |link|
#   click_link link
# end
# 
# When /^fill in and submit the form with my user data$/ do
#   fill_in 'Name', :with => @user[:name]
#   fill_in 'Email', :with => @user[:email]
#   fill_in 'Password', :with => @user[:password]
#   fill_in 'Password confirmation', :with => @user[:password]
#   click_button "Sign up"
# end
# 
# Then /^I see "([^"]*)"$/ do |text|
#   page.should have_content(text)
# end
# 

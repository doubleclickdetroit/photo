#Successful account sign-up
Given /^I have the following information$/ do |user|
  @user = user.hashes.first
end

Given /^I am not a registered user$/ do
  User.destroy_all
end

When /^I visit the home page$/ do
  visit root_path
end

When /^click "([^"]*)"$/ do |link|
  click_link link
end

When /^fill in and submit the form with my user data$/ do
  fill_in 'First', :with => @user[:first]
  fill_in 'Last', :with => @user[:last]
  fill_in 'Email', :with => @user[:email]
  # fill_in 'Organization Name', :with => @user[:group_name]
  fill_in 'Password', :with => @user[:password]
  fill_in 'Password confirmation', :with => @user[:password]
  click_button "Sign up"
end

Then /^I see "([^"]*)"$/ do |text|
  page.should have_content(text)
end

# user_auth_steps.rb
# Given /^I have the following information$/ do |user|

Given /^I have never submitted it before$/ do
  Prospect.destroy_all
end

Given /^I have submitted it before$/ do
  @user.save
end

When /^I visit the teaser page$/ do
  visit root_path
end

When /^submit my email address and info$/ do
  fill_in "First", :with => @user[:first]
  fill_in "Last", :with => @user[:last]
  fill_in "Email", :with => @user[:email]
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

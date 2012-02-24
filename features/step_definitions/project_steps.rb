Given /^I belong to a group$/ do
  @group = Factory(:group)
end

Given /^I am an? "([^"]*)" for that group$/ do |role|
  @user.enroll_in(@group, :as => role.intern)
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, val|
  fill_in field, :with => val
end

When /^(I )?press "([^"]*)"$/ do |blank_arg,button|
  click_button button
end

Given /^there are many projects that do not belong to my group$/ do
  @other_group = Factory(:group)
  3.times { @other_group.projects << Project.new(:name => 'Foo Project')}
end

Then /^I shouldn't see the projects that don't belong$/ do
  page.should_not have_content('Foo Project')
end

When /^I navigate to that project$/ do
  visit project_path(@project)
end

Then /^I should be redirected to "([^"]*)"$/ do |path|
  current_path.should == path 
end



def current_path
  URI.parse(current_url).path
end

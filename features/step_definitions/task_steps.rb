Given /^that group already has a project named "([^"]*)"$/ do  |name|
  @project = Factory(:project, :name => name)
  @group.projects << @project
end

When /^select "([^"]*)" from "([^"]*)"$/ do |option, dropdown|
  select(option, :from => dropdown)
end

Given /^that project already has several tasks$/ do
  3.times { @project.entities << Factory(:task) }
  @tasks = @project.tasks
end

Then /^I should see all the tasks' titles$/ do
  @tasks.each do |task|
    page.should have_content(task.title)
  end
end

Given /^that project already has an task$/ do
  @project.entities << Factory(:task)
end

# When /^confirm the dialog$/ do
#   page.driver.browser.switch_to().alert.accept
# end

# When /^click "([^"]*)" and confirm the dialog$/ do |link|
#   #dialog hack
#   page.evaluate_script('window.confirm = function() { return true; }')
#   page.click('Remove')
# 
#   click_link link
# end

# Then /^I should be on "([^"]*)"$/ do |path|
#   current_path.should == path 
# end

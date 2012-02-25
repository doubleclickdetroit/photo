Given /^that group already has a project named "([^"]*)"$/ do |name|
  @project = Factory(:project, :name => name)
  @group.projects << @project
end

When /^select "([^"]*)" from "([^"]*)"$/ do |option, dropdown|
  select(option, :from => dropdown)
end

Given /^that project already has several entities$/ do
  3.times { @project.entities << Factory(:entity) }
  @entities = @project.entities
end

Then /^I should see all the entities' titles$/ do
  @entities.each do |entity|
    page.should have_content(entity.title)
  end
end

# Then /^I should be on "([^"]*)"$/ do |path|
#   current_path.should == path 
# end

Given /^my information is as follows$/ do |info|
  @info = info.hashes.first
end

When /^I am invited to join a group named "([^"]*)"$/ do |name|
  @group = Factory(:group, :name => name) 
  @invitation = Factory :invitation, 
                        :first => @info[:first],
                        :last  => @info[:last],
                        :email => @info[:email]
end

Then /^I should receive an email invitation$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^it should contain the group name$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^my first name$/ do
  pending # express the regexp above with the code you wish you had
end

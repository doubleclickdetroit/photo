Given /^my information is as follows$/ do |info|
  @info = info.hashes.first
end

When /^I am invited to join a group named "([^"]*)"$/ do |name|
  @group = Factory(:group, :name => name) 
  @invitation = Factory :invitation, 
                        :first => @info[:first],
                        :last  => @info[:last],
                        :email => @info[:email],
end

Then /^I should receive an email invitation containing the proper information$/ do
  @email = ActionMailer::Base.deliveries.first

  # todo check its from the proper email addy?
  # @email.from.should == "admin@example.com"

  # group info
  @email.body.should include(@group.name)

  # user info
  @email.to.should   == @info[:email]
  @email.body.should include(@info[:first])
end

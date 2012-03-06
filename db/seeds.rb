# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

@ben  = Factory(:user, :first => 'Ben', :last => 'Babics')
@brad = Factory(:user, :first => 'Brad', :last => 'Chase')
@josh  = Factory(:user, :first => 'Josh', :last => 'Yurich')

@group = Factory(:group, :name => 'DoubleClick Detroit')

# puts @ben.inspect, @group.inspect

@ben.enroll_in @group, :as => :owner
@josh.enroll_in @group, :as => :admin
@brad.enroll_in @group, :as => :associate

@project = Factory(:project, :name => 'Timeline CRM')
@group.projects << @project

# # today being between the 11th and 16th
# 
# events = [
# ]

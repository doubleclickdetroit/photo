# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

##################################
######## Users & Group ###########
##################################

@ben  = Factory(:user, :first => 'Ben', :last => 'Babics')
@brad = Factory(:user, :first => 'Brad', :last => 'Chase')
@josh  = Factory(:user, :first => 'Josh', :last => 'Yurich')

@group = Factory(:group, :name => 'DoubleClick Detroit')

@ben.enroll_in @group, :as => :owner
@josh.enroll_in @group, :as => :admin
@brad.enroll_in @group, :as => :associate



##################################
########### Project ##############
##################################

@project = Factory(:project, :name => 'Timeline CRM')
@group.projects << @project

def hour_and_minute_for_date(hour, minute, date)
  DateTime.new date.year, date.month, date.day, hour, minute
end



##################################
############ Events ##############
##################################

events = [
  {
    :title => 'Meet with Client',
    :text => 'Lorem ipsum dolor sit amet elictar, visit their website www.example.com',
    :time_place => {  
      :start  => hour_and_minute_for_date(10,00,4.days.ago),
      :finish => hour_and_minute_for_date(14,30,4.days.ago),
      :address1 => 'ACME CO',
      :address2 => '1776 Independence St',
      :address3 => 'Commerce, MI 48382'
    }
  },
  {
    :title => 'Discuss Requirements Documentation',
    :text => 'Lorem ipsum dolor sit amet elictar, visit their website www.example.com',
    :time_place => {  
      :start  => hour_and_minute_for_date(13,00,3.days.ago),
      :finish => hour_and_minute_for_date(14,00,3.days.ago),
      :address1 => 'War Room',
      :address2 => '2nd Floor',
      :address3 => nil
    }
  },
  {
    :title => 'Discuss Wireframes & Mockups',
    :text => 'Lorem ipsum dolor sit amet elictar, visit their website www.example.com',
    :time_place => {  
      :start  => hour_and_minute_for_date(10,30,Time.now),
      :finish => hour_and_minute_for_date(12,00,Time.now),
      :address1 => 'Green Room',
      :address2 => '1st Floor',
      :address3 => nil
    }
  },
  {
    :title => 'Discuss questions & assumptions',
    :text => 'Lorem ipsum dolor sit amet elictar, visit their website www.example.com',
    :time_place => {  
      :start  => hour_and_minute_for_date(14,00,5.days.from_now),
      :finish => hour_and_minute_for_date(15,00,5.days.from_now),
      :address1 => 'Starbucks Coffee',
      :address2 => '1983 Cheshire Ln',
      :address3 => 'Commerce, MI 48382'
    }
  },
  {
    :title => 'Discuss estimate of hours',
    :text => 'Lorem ipsum dolor sit amet elictar, visit their website www.example.com',
    :time_place => {  
      :start  => hour_and_minute_for_date(14,00,9.days.from_now),
      :finish => hour_and_minute_for_date(15,00,9.days.from_now),
      :address1 => 'Conference Call',
      :address2 => '(866) 555-5555',
      :address3 => 'www.example.com'
    }
  }
]

events.each do |event| 
  # todo: this is all super-stupid
  # get nested attributes to work
  time_place  = event.delete :time_place

  @time_place = Factory(:time_place, time_place)
  @event      = Factory(:event, event)

  @event.time_place = @time_place
  @project.entities << @event
end



##################################
############# Tasks ##############
##################################

tasks = [
  {
    :title => 'Attach Requirements Documentation',
    :text => nil,
    :deadline => {  
      :due => 3.days.ago,
      :complete => true
    }
  },
  {
    :title => 'Attach wireframes and mockups',
    :text => nil,
    :deadline => {  
      :due => 1.day.ago,
      :complete => true
    }
  }
]

tasks.each do |task|
  deadline = task.delete :deadline

  @task     = Factory(:task, task)
  @deadline = Factory(:deadline, deadline)

  @task.deadline = @deadline
  @project.entities << @task
end



##################################
############ Embeds ##############
##################################

embeds = [
  {
    :title => 'Requirements Documentation',
    :text => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam blandit ornare aliquam. Integer fringilla euismod lacus, sit amet faucibus urna tincidunt ac.',
    :created_at => 3.days.ago,

    :asset => { :file_path => ['test','fixtures','test.doc'] }
  },
  {
    :title => 'Wireframes',
    :text => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam blandit ornare aliquam. Integer fringilla euismod lacus, sit amet faucibus urna tincidunt ac.',
    :created_at => 1.day.ago,

    :asset => { :file_path => ['test','fixtures','test.pdf'] }
  },
  {
    :title => 'Mockups',
    :text => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam blandit ornare aliquam. Integer fringilla euismod lacus, sit amet faucibus urna tincidunt ac.',
    :created_at => 1.day.ago,

    :asset => { :file_path => ['test','fixtures','test.pdf'] }
  }
]

embeds.each do |embed|
  asset  = embed.delete :asset
  file = Rails.root.join(*asset[:file_path]).open

  @embed = Factory(:embed, embed)
  @embed.file = file 

  @project.entities << @embed
end

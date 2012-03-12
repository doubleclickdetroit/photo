# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts "** Begin Seeding"



##################################
######## Users & Group ###########
##################################

puts "  ** Building Users"

@ben  = Factory(:user, :first => 'Ben', :last => 'Babics')
@brad = Factory(:user, :first => 'Brad', :last => 'Chase')
@josh  = Factory(:user, :first => 'Josh', :last => 'Yurich')

puts "  ** Building/Associating Groups"

@group = Factory(:group, :name => 'DoubleClick Detroit')

@ben.enroll_in @group, :as => :owner
@josh.enroll_in @group, :as => :admin
@brad.enroll_in @group, :as => :associate

@users = @group.members


##################################
########### Project ##############
##################################

puts "  ** Building Project"

@project = Factory(:project, :name => 'Timeline CRM')
@group.projects << @project

def hour_and_minute_for_date(hour, minute, date)
  DateTime.new date.year, date.month, date.day, hour, minute
end



##################################
############ Events ##############
##################################

puts "    ** Adding Events"

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

puts "    ** Adding Tasks"

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

puts "    ** Adding Embeds"

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

  @asset = Factory(:asset)
  @asset.file = file
  @embed = Factory(:embed, embed)
  @embed.asset = @asset

  @project.entities << @embed
end



#####################################
### Random Comments and Followers ###
#####################################

puts "    ** Adding Arbitrary Comments/Followers"

def random_user
  @users[rand(@users.size)]
end

def random_text
  @lines ||= "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam id vulputate leo. Suspendisse vulputate libero eu leo ornare adipiscing. Cras mattis tristique mollis. Aenean et metus neque, nec porta lacus. Sed quis semper nisl. Nunc vel mi sem, vitae imperdiet metus. Suspendisse purus metus, pulvinar ac scelerisque et, rutrum ultrices urna. Sed faucibus placerat turpis, sed luctus odio aliquam nec. Integer justo diam, rhoncus in malesuada ac, eleifend eget libero. Praesent congue suscipit urna eu semper. Vestibulum velit nisl, porta sit amet aliquam faucibus, semper vel eros. Proin arcu massa, iaculis et malesuada dignissim, egestas eu diam. Vestibulum eleifend ante id nisl sollicitudin ac faucibus diam hendrerit. Vivamus vitae ipsum dui, et tincidunt felis. Nullam posuere odio egestas sapien ornare convallis. Nullam eget mi vel lorem mollis gravida. Mauris quam velit, malesuada nec tempor ac, dapibus quis augue. Suspendisse potenti.".split(/\./).map(&:strip)

  text = ''
  (rand(4)+1).times { text << (@lines[rand(@lines.size)]+". ") }
  text
end

Entity.all.each do |ent|
  #comments
  (rand(5)+1).times do
    comment = Factory(:comment, :user_id => random_user().id, :text => random_text())
    ent.comments << comment
  end

  #followers
  users = @users
  # rand(@users.size).times do
  #   # [true,false].sample ? users.shift : users.pop
  #   rand(2)==1 ? users.shift : users.pop
  # end
  # puts "number of followers: #{users.size}"
  ent.followers = users
end



puts "** Done Seeding"

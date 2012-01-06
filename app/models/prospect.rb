class Prospect < ActiveRecord::Base
  validates_presence_of :first, :last, :email
  validates_uniqueness_of :email

  THANKYOU = {:title => "Thank you!", :text => "We'll be sure to keep you updated and inform you as soon as our new service is live!"}
  ADVERTISEMENTS = Hash[[    
     "Imaging USA",
     "PPI",
     "creatliveLIVE",
     "Zach & Jody Newsletter",
     "Other"
  ].map {|i| [i,i]} ]
end

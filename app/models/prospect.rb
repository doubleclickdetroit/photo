class Prospect < ActiveRecord::Base
  validates_presence_of :first, :last, :email
  validates_uniqueness_of :email

  ADVERTISEMENTS = Hash[[    
     "Imaging USA",
     "PPI",
     "creatliveLIVE",
     "Zach & Jody Newsletter",
     "Other"
  ].map {|i| [i,i]} ]
end

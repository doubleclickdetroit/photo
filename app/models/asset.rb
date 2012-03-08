class Asset < ActiveRecord::Base 
  belongs_to :entity

  has_attached_file :attachment

  delegate :url, :to => :attachment, :prefix => true
end

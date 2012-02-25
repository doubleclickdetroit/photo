class Project < ActiveRecord::Base
  belongs_to :group
  has_many :entities
end

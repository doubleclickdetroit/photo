class Group < ActiveRecord::Base
  # user associations
  has_many :memberships
  has_many :members, :through => :memberships, :source => 'user'

  # project associations
  has_many :projects

  def enroll(*args)
    user = args.shift
    role = args.extract_options![:as]
    self.members << user
    m = Membership.for(self,user)
    m.roles = [:owner]
    m.save
  end
end

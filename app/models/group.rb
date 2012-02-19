class Group < ActiveRecord::Base
  has_many :memberships
  has_many :members, :through => :memberships, :source => 'user'

  def enroll(*args)
    user = args.shift
    role = args.extract_options![:as]
    self.members << user
    m = Membership.for(self,group)
    m.roles = [:owner]
    m.save
  end
end

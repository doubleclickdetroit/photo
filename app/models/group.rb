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

  def to_hash
    hash = {
      'id' => self.id,
      'name' => self.name
    }

    hash['users'] = self.members.map do |u|
      u.to_hash.merge 'roles' => u.roles_for(self).map(&:to_s)
    end

    hash
  end
end

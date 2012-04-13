class Group < ActiveRecord::Base
  # user associations
  has_many :memberships
  has_many :members, :through => :memberships, :source => 'user'

  # project associations
  has_many :projects
  has_many :invitations

  def enroll(*args)
    user = args.shift
    role = args.extract_options![:as]
    self.members << user
    m = Membership.for(self,user)
    m.roles = [:owner]
    m.save
  end

  def simple_hash
    hash = attributes

    hash['users'] = members.map do |u|
      u.to_hash(self) # self allows roles to be defined
    end
    hash['projects'] = projects.map(&:simple_hash)

    hash
  end

  # todo may not be necessary
  def to_hash
    hash = simple_hash
    hash
  end

  def to_json(full=false)
    hash = full ? to_hash : simple_hash
    hash.to_json
  end
end

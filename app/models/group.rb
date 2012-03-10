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
      %w(id first last email).inject({}) do |hash,att|
        hash[att] = u.send att; hash
      end
    end

    hash
  end
end

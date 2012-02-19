class User < ActiveRecord::Base
  # extend FriendlyId
  # friendly_id :name, use: :slugged

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  # todo dependent destroy...
  has_many :memberships
  has_many :groups, :through => :memberships

  def membership_for(group)
    Membership.for(self, group)
  end

  def roles_for(group)
    self.membership_for(group).roles
  end

  def has_role?(*args)
    role  = args.shift
    group = args.extract_options![:for]
    self.membership_for(group).role? role
  end

  def enroll_in(*args)
    group = args.shift
    role  = args.extract_options![:as]
    group.members << self
    m = Membership.for(self,group)
    m.roles = [:owner]
    m.save
  end

  # overriding groups to accomodate roles in memberships
  # todo fix, slow
  # alias :groups_orig :groups
  # def groups
  #   groups_orig.each do |g|
  #     m = Membership.where(:group_id => g.id, :user_id => self.id).first
  #     g.instance_eval { def roles; m.roles; end }
  #   end
  # end
end

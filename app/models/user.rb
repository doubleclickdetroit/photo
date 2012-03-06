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
  attr_accessible :name, :email, :avatar, :password, :password_confirmation, :remember_me

  has_attached_file :avatar, :styles => { :icon => '30x30', :small => '100x100' },
                    :default_url => "/assets/default_:style_avatar.png",
                    :default_style => :icon

  has_many :comments

  # todo dependent destroy...
  has_many :memberships
  has_many :groups, :through => :memberships

  def membership_for(group)
    Membership.for(self, group)
  end

  def roles_for(group)
    membership_for(group).try(:roles) || []
  end

  # @user.has_role? :admin, :for => @group
  # @user.has_role? [:owner,:admin], :for => @group
  def has_role?(*args)
    roles = ([] << args.shift).flatten
    group = args.extract_options![:for]
    raise ArgumentError, "Expected arg :for => group_instance" unless group
    has_role = false
    roles.each { |role| has_role = true if roles_for(group).include?(role) }
    has_role
  end

  def enroll_in(*args)
    group = args.shift
    role  = args.extract_options![:as]
    raise ArgumentError, "Expected arg :as => :role_symbol" unless role
    group.members << self
    m = self.membership_for(group)
    m.roles = [role]
    m.save
  end
end

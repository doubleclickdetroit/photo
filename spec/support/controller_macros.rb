module ControllerMacros
  def login_admin
    # why before each?
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      user  = Factory.create(:user) 
      group = Factory.create(:group)
      user.enroll_in(group, :as => :admin)
      sign_in user 

      valid_attributes = { :group_id => @group.id }
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = Factory.create(:user)
      # user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
      sign_in user
    end
  end
end

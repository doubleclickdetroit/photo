module ControllerMacros
  def login_owner
    before(:each) do
      @user = Factory(:user)
      @the_group = Factory(:group)
      @user.enroll_in @the_group, :as => :owner
      @other_group = Factory(:group)

      # @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user 
    end
  end

  def login_admin
    before(:each) do
      @user = Factory(:user)
      @the_group = Factory(:group)
      @user.enroll_in @the_group, :as => :admin
      @other_group = Factory(:group)

      # @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user 
    end
  end

  def login_associate
    before(:each) do
      @user  = Factory(:user)
      @the_group = Factory(:group)
      @user.enroll_in @the_group, :as => :associate
      @other_group = Factory(:group)

      # @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user 
    end
  end

  def login_user
    before(:each) do
      @user  = Factory(:user)
      @the_group = Factory(:group)

      # @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user 
    end
  end
end

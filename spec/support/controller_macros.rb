module ControllerMacros
  def login_admin
    before(:each) do
      @user  = Factory(:user)
      @group = Factory(:group)
      @user.enroll_in @group, :as => :admin

      # @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user 
    end
  end

  def login_associate
    before(:each) do
      @user  = Factory(:user)
      @group = Factory(:group)
      @user.enroll_in @group, :as => :associate

      # @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user 
    end
  end

  def login_user
    before(:each) do
      @user  = Factory(:user)

      # @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user 
    end
  end
end

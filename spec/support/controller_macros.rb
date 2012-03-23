module ControllerMacros
  def arbitrary_projects
    before(:all) do
      @project = Factory(:project)
      @group.projects << @project

      @other_project = Factory(:project)
      @group.other_projects << @other_project
    end
  end

  def arbitrary_entities
    before(:all) do
      @event = Factory(:event)
      @other_event = Factory(:event)
      @project.entities << @event
      @other_project.entities << @other_event

      @task = Factory(:task)
      @other_task = Factory(:task)
      @project.entities << @task
      @other_project.entities << @other_task

      @embed = Factory(:embed)
      @other_embed = Factory(:embed)
      @project.entities << @embed
      @other_project.entities << @other_embed
    end
  end

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

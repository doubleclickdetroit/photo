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

  def login_admin_and_populate_projects_and_entities
    before(:each) do
      @user = Factory(:user)
      @the_group = Factory(:group)
      @user.enroll_in @the_group, :as => :admin
      @other_group = Factory(:group)

      @project = Factory(:project)
      @phase = Factory(:phase)
      @project.phases << @phase
      @the_group.projects << @project

      @other_project = Factory(:project)
      @other_phase = Factory(:phase)
      @other_project.phases << @other_phase
      @other_group.projects << @other_project

      @event = Factory(:event)
      @other_event = Factory(:event)
      @phase.entities << @event
      @other_phase.entities << @other_event

      @task = Factory(:task)
      @other_task = Factory(:task)
      @phase.entities << @task
      @other_phase.entities << @other_task

      @embed = Factory(:embed)
      @other_embed = Factory(:embed)
      @phase.entities << @embed
      @other_phase.entities << @other_embed

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

  def it_should_check_permissions(params, session, *actions)
    actions.each do |action|
      it "#{action} action should authorize user to do this action" do
        ability = Object.new
        ability.extend(CanCan::Ability)
        controller.stub!(:current_ability).and_return(ability)

        ability.should_receive(:can?)
        get action, params, session
      end
    end    
  end
end

require 'spec_helper'

describe ProjectsController do
  attr_accessor :valid_attributes, :valid_session

  describe 'user logged in, not a group member' do
    pending 'not sure why, but login_user is granting access...'
    # login_user()
    # describe "GET index" do
    #   it "redirects to sign_in" do
    #     project = Factory(:project)
    #     get :index, {}, valid_session
    #     flash = 'You need to sign in or sign up before continuing.'
    #     response.should redirect_to(new_user_session_path)
    #   end
    # end
  end


  context 'user not logged in' do
    let(:sign_in_alert) {'You need to sign in or sign up before continuing.'}

    describe "GET index" do
      it "redirects to sign_in with flash alert" do
        get :index, {}, valid_session
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == sign_in_alert
      end
    end

    describe "GET show" do
      it "redirects to sign_in with flash alert" do
        project = Factory(:project)
        get :show, {:id => project.to_param}, valid_session
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == sign_in_alert
      end
    end

    describe "GET new" do
      it "redirects to sign_in with flash alert" do
        pending 'excepted this in the controller i think...'
        get :new, {:group_id => @group.id}, valid_session
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == sign_in_alert
      end
    end

    describe "GET edit" do
      it "redirects to sign_in with flash alert" do
        project = Factory(:project)
        get :edit, {:id => project.to_param}, valid_session
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == sign_in_alert
      end
    end

    describe "POST create" do
      it "redirects to sign_in with flash alert" do
        post :create, {:project => {}}, valid_session
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == sign_in_alert
      end
    end

    describe "PUT update" do
      it "redirects to sign_in with flash alert" do
        project = Factory(:project)
        put :update, {:id => project.to_param, :project => {}}, valid_session
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == sign_in_alert
      end
    end

    describe "DELETE destroy" do
      it "redirects to sign_in with flash alert" do
        project = Factory(:project)
        delete :destroy, {:id => project.to_param}, valid_session
        response.should redirect_to(new_user_session_path)
        flash[:alert].should == sign_in_alert
      end
    end
  end


  context 'associate for group logged in' do
    let(:access_denied_alert) { 'You are not authorized to access this page.' }

    login_associate()

    describe "GET index" do
      it "assigns all projects as @projects" do
        project = Factory(:project)
        get :index, {}, valid_session
        assigns(:projects).should eq([project])
      end
    end

    describe "GET show" do
      it "assigns the requested project as @project" do
        project = Factory(:project)
        get :show, {:id => project.to_param}, valid_session
        assigns(:project).should eq(project)
      end
    end

    describe "GET new" do
      it "redirects to root with flash alert" do
        pending 'excepted this in the controller i think...'
        get :new, {:group_id => @group.id}, valid_session
        response.should redirect_to(root_path)
        flash[:alert].should == access_denied_alert
      end
    end

    describe "GET edit" do
      it "redirects to root with flash alert" do
        project = Factory(:project)
        get :edit, {:id => project.to_param}, valid_session
        response.should redirect_to(root_path)
        flash[:alert].should == access_denied_alert
      end
    end

    describe "POST create" do
      it "redirects to root with flash alert" do
        post :create, {:project => {:group_id => @group.id}}, valid_session
        response.should redirect_to(root_path)
        flash[:alert].should == access_denied_alert
      end
    end

    describe "PUT update" do
      it "redirects to root with flash alert" do
        project = Factory(:project) 
        put :update, {:id => project.to_param, :project => {}}, valid_session
        response.should redirect_to(root_path)
        flash[:alert].should == access_denied_alert
      end
    end

    describe "DELETE destroy" do
      it "redirects to root with flash alert" do
        project = Factory(:project) 
        delete :destroy, {:id => project.to_param}, valid_session
        response.should redirect_to(root_path)
        flash[:alert].should == access_denied_alert
      end
    end
  end


  context 'admin for group logged in' do
    login_admin()

    describe "GET index" do
      it "assigns all projects as @projects" do
        project = Factory(:project)
        get :index, {}, valid_session
        assigns(:projects).should eq([project])
      end
    end

    describe "GET show" do
      it "assigns the requested project as @project" do
        project = Factory(:project)
        get :show, {:id => project.to_param}, valid_session
        assigns(:project).should eq(project)
      end
    end

    describe "GET new" do
      it "assigns a new project as @project" do
        get :new, {:group_id => @group.id}, valid_session
        assigns(:project).should be_a_new(Project)
      end
    end

    # make others from here
    describe "GET edit" do
      it "assigns the requested project as @project" do
        project = Factory(:project)
        get :edit, {:id => project.to_param}, valid_session
        assigns(:project).should eq(project)
      end
    end

    describe "POST create" do
      let(:valid_attributes) { Factory.build(:project).attributes }

      describe "with valid params" do
        it "creates a new Project" do
          expect {
            post :create, {:project => valid_attributes}, valid_session
          }.to change(Project, :count).by(1)
        end

        it "assigns a newly created project as @project" do
          post :create, {:project => valid_attributes}, valid_session
          assigns(:project).should be_a(Project)
          assigns(:project).should be_persisted
        end

        it "redirects to the created project" do
          post :create, {:project => valid_attributes}, valid_session
          response.should redirect_to(Project.last.group)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved project as @project" do
          pending 'not really sure...'
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          post :create, {:project => {}}, valid_session
          assigns(:project).should be_a_new(Project)
        end

        it "re-renders the 'new' template" do
          pending 'not really sure...'
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          post :create, {:project => {}}, valid_session
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      let(:valid_attributes) do
        { :name => 'Project PUT' }
      end

      describe "with valid params" do
        it "updates the requested project" do
          project = Factory(:project)
          # Assuming there are no other projects in the database, this
          # specifies that the Project created on the previous line
          # receives the :update_attributes message with whatever params are
          # submitted in the request.
          Project.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, {:id => project.to_param, :project => {'these' => 'params'}}, valid_session
        end

        it "assigns the requested project as @project" do
          project = Factory(:project) 
          put :update, {:id => project.to_param, :project => valid_attributes}, valid_session
          assigns(:project).should eq(project)
        end

        it "redirects to the project" do
          project = Factory(:project, :group_id => @group.id) 
          put :update, {:id => project.to_param, :project => valid_attributes}, valid_session
          response.should redirect_to(project)
        end
      end

      describe "with invalid params" do
        it "assigns the project as @project" do
          project = Factory(:project) 
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          put :update, {:id => project.to_param, :project => {}}, valid_session
          assigns(:project).should eq(project)
        end

        it "re-renders the 'edit' template" do
          project = Factory(:project) 
          # Trigger the behavior that occurs when invalid params are submitted
          Project.any_instance.stub(:save).and_return(false)
          put :update, {:id => project.to_param, :project => {}}, valid_session
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested project" do
        project = Factory(:project)  
        expect {
          delete :destroy, {:id => project.to_param}, valid_session
        }.to change(Project, :count).by(-1)
      end

      it "redirects to the projects list" do
        pending 'no idea why this throws a 406'
        project = Factory(:project, :group_id => @group.id)  
        delete :destroy, {:id => project.to_param}, valid_session
        response.should redirect_to(projects_url)
      end
    end

  end
end

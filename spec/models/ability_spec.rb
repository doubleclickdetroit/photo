require 'spec_helper'
require 'cancan/matchers'

def before_each_comment_spec
  before(:each) do
    project = Factory(:project)
    group.projects << project

    entity = Factory(:entity)
    project.entities << entity

    @other_comment = Factory(:comment)
    entity.comments << @other_comment

    @own_comment = Factory(:comment, :user_id => @user.id)
    entity.comments << @own_comment

    project = Factory(:project)
    other_group.projects << project

    entity = Factory(:entity)
    project.entities << entity

    @other_group_comment = Factory(:comment)
    entity.comments << @other_group_comment
  end
end

def before_each_watching_spec
  before(:each) do
    project = Factory(:project)
    group.projects << project

    entity = Factory(:entity)
    project.entities << entity

    @watching = Factory(:watching, :user_id => @user.id)
    entity.watchings << @watching

    project = Factory(:project)
    other_group.projects << project

    entity = Factory(:entity)
    project.entities << entity

    @other_watching = Factory(:watching)
    entity.watchings << @other_watching
  end
end

describe User do
  before(:each) do
    @user  = Factory(:user)
    @group = Factory(:group)
  end

  describe 'abilities' do
    let(:ability){ Ability.new(@user) }
    subject { ability }

    let(:group){ Factory(:group) }
    let(:other_group){ Factory(:group) }

    let(:project) do
      project = Factory(:project) 
      group.projects << project
      project
    end
    let(:other_project) do
      other_project = Factory(:project) 
      other_group.projects << other_project
      other_project
    end

    let(:entity) do
      entity = Factory(:entity) 
      project.entities << entity
      entity
    end
    let(:other_entity) do
      other_entity = Factory(:entity) 
      other_project.entities << other_entity
      other_entity
    end

    context "as owner" do
      before(:each) do
        @user = Factory(:user) 
        @user.enroll_in group, :as => :owner
      end

      describe 'for Group' do
        it { should be_able_to(:manage, group) }
      end

      describe 'for Project' do
        it { should be_able_to(:manage, project) }
        it { should_not be_able_to(:manage, other_project) }
      end

      describe 'for Entity' do
        it { should be_able_to(:manage, entity) }
        it { should_not be_able_to(:manage, other_entity) }
      end

      describe 'for Invitation' do
        it { should be_able_to(:create, Factory(:invitation,:inviter => @user, :group => group)) }
        it { should_not be_able_to(:create, Factory(:invitation,:inviter => @user, :group => other_group)) }
      end

      describe 'for Comment' do
        before_each_comment_spec()

        it { should be_able_to(:create, @own_comment) }

        it { should be_able_to(:read, @own_comment) }
        it { should be_able_to(:update, @own_comment) }
        it { should be_able_to(:destroy, @own_comment) }

        it { should be_able_to(:read, @other_comment) }
        it { should_not be_able_to(:update, @other_comment) }
        it { should_not be_able_to(:destroy, @other_comment) }

        it { should_not be_able_to(:create, @other_group_comment) }
        it { should_not be_able_to(:read, @other_group_comment) }
        it { should_not be_able_to(:update, @other_group_comment) }
        it { should_not be_able_to(:destroy, @other_group_comment) }
      end

      describe 'for Watching' do
        before_each_watching_spec()

        it { should be_able_to([:create,:destroy], @watching)}
        it { should_not be_able_to([:create,:destroy], @other_watching)}
      end
    end

    context "as admin" do
      before(:each) do
        @user = Factory(:user) 
        @user.enroll_in group, :as => :admin 
      end
      
      describe 'for Group' do
        it { should be_able_to(:read, group) }
        # todo doesnt need to allow create... right? 
        # it { should be_able_to(:create, group) }
        it { should be_able_to(:update, group) }
        it { should_not be_able_to(:destroy, group) }
      end

      describe 'for Project' do
        it { should be_able_to(:manage, project) }
        it { should_not be_able_to(:manage, other_project) }
      end

      describe 'for Entity' do
        it { should be_able_to(:manage, entity) }
        it { should_not be_able_to(:manage, other_entity) }
      end

      describe 'for Invitation' do
        it { should be_able_to(:create, Factory(:invitation,:inviter => @user, :group => group)) }
        it { should_not be_able_to(:create, Factory(:invitation,:inviter => @user, :group => other_group)) }
      end

      describe 'for Comment' do
        before_each_comment_spec()

        it { should be_able_to(:create, @own_comment) }

        it { should be_able_to(:read, @own_comment) }
        it { should be_able_to(:update, @own_comment) }
        it { should be_able_to(:destroy, @own_comment) }

        it { should be_able_to(:read, @other_comment) }
        it { should_not be_able_to(:update, @other_comment) }
        it { should_not be_able_to(:destroy, @other_comment) }

        it { should_not be_able_to(:create, @other_group_comment) }
        it { should_not be_able_to(:read, @other_group_comment) }
        it { should_not be_able_to(:update, @other_group_comment) }
        it { should_not be_able_to(:destroy, @other_group_comment) }
      end
    end

    context "as associate" do
      before(:each) do
        @user = Factory(:user) 
        @user.enroll_in group, :as => :associate 
      end
      
      describe 'for Group' do
        it { should be_able_to(:read, group) }
        it { should_not be_able_to(:create, group) }
        it { should_not be_able_to(:update, group) }
        it { should_not be_able_to(:destroy, group) }
      end

      describe 'for Project' do
        it { should be_able_to(:read, project) }
        it { should_not be_able_to(:create, project) }
        it { should_not be_able_to(:update, project) }
        it { should_not be_able_to(:destroy, project) }
      end

      describe 'for Entity' do
        it { should be_able_to(:read, entity) }
        it { should be_able_to(:create, entity) }
        it { should be_able_to(:update, entity) }
        it { should_not be_able_to(:destroy, entity) }
      end

      describe 'for Invitation' do
        it { should_not be_able_to(:create, Factory(:invitation,:inviter => @user, :group => other_group)) }
      end

      describe 'for Comment' do
        before_each_comment_spec()

        it { should be_able_to(:create, @own_comment) }

        it { should be_able_to(:read, @own_comment) }
        it { should be_able_to(:update, @own_comment) }
        it { should be_able_to(:destroy, @own_comment) }

        it { should be_able_to(:read, @other_comment) }
        it { should_not be_able_to(:update, @other_comment) }
        it { should_not be_able_to(:destroy, @other_comment) }

        it { should_not be_able_to(:create, @other_group_comment) }
        it { should_not be_able_to(:read, @other_group_comment) }
        it { should_not be_able_to(:update, @other_group_comment) }
        it { should_not be_able_to(:destroy, @other_group_comment) }
      end
    end

    context "as user not in group" do
      before(:each) do
        @user = Factory(:user) 
      end
      
      describe 'for Group' do
        it { should_not be_able_to(:read, group) }
        it { should_not be_able_to(:create, group) }
        it { should_not be_able_to(:update, group) }
        it { should_not be_able_to(:destroy, group) }
      end

      describe 'for Project' do
        it { should_not be_able_to(:read, project) }
        it { should_not be_able_to(:create, project) }
        it { should_not be_able_to(:update, project) }
        it { should_not be_able_to(:destroy, project) }
      end

      describe 'for Entity' do
        it { should_not be_able_to(:read, entity) }
        it { should_not be_able_to(:create, entity) }
        it { should_not be_able_to(:update, entity) }
        it { should_not be_able_to(:destroy, entity) }
      end

      describe 'for Invitation' do
        it { should_not be_able_to(:create, Factory(:invitation,:inviter => @user, :group => other_group)) }
      end

      describe 'for Comment' do
        before_each_comment_spec()

        it { should_not be_able_to(:create, @other_group_comment) }
        it { should_not be_able_to(:read, @other_group_comment) }
        it { should_not be_able_to(:update, @other_group_comment) }
        it { should_not be_able_to(:destroy, @other_group_comment) }
      end
    end

  end
end

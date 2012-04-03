require 'spec_helper'
require 'cancan/matchers'

describe User do
  before(:each) do
    @user  = Factory(:user)
    @group = Factory(:group)
  end

  describe 'abilities' do
    subject { ability }
    let(:ability){ Ability.new(@user) }

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
    end

  end
end

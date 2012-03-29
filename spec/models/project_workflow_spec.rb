require 'spec_helper'

describe ProjectWorkflow do
  # todo stash this somewhere sensical
  before(:each) do
    @owner     = Factory(:user)
    # @admin     = Factory(:user)
    # @associate = Factory(:user)

    @group     = Factory(:group)
    
    # todo this in a factory
    @owner.enroll_in @group, :as => :owner
    # @admin.enroll_in @group, :as => :admin
    # @associate.enroll_in @group, :as => :associate
  end

  before(:each) { @workflow = Factory(:project_workflow) }
  subject { @workflow }

  # its going to need to override #to_hash
  # and have some variation on #entities_by_month_and_date

  describe '#generate_project_from' do
    context 'given an Invitation' do
      let(:invitation) { Factory(:invitation, :group_id => @group.id, :inviter_id => @owner.id) }
      let(:project) { ProjectWorkflow.generate_project_from(invitation) }

      it 'should call #project_from_invitation' do
        pending 'wtf, receiving twice?'
        ProjectWorkflow.should_receive :project_from_invitation
        ProjectWorkflow.generate_project_from(invitation)
      end

      it 'should call RegistrationForm#generate_form_data_from' do
        pending 'wtf'
        RegistrationForm.any_instance.should_receive :generate_form_data_from
        ProjectWorkflow.generate_project_from(invitation)
      end


      subject { project }

      it { should be_an_instance_of Project }
      it { should_not be_an_instance_of ProjectWorkflow }
      it { should_not be_a_new_record }

      describe '#entities' do
        let(:entities) { project.entities }

        it 'should contain one completed Task' do
          entities.one? {|e| e.instance_of?(Task)}.should be_true
          task = entities.find {|e| e.instance_of?(Task)}
          task.complete.should be_true
        end

        it 'should contain a RegistrationForm' do
          entities.one? {|e| e.instance_of?(RegistrationForm)}.should be_true
        end
      end
    end
  end

end

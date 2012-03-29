require 'spec_helper'

describe Entity do
  describe Task do
    before(:each) do
      @user = Factory(:user)
      @task = Factory(:task)
      @deadline = Factory(:deadline)
      @task.deadline = @deadline
    end

    describe '#due' do
      it 'should return the due date from the associated Deadline' do
        @task.due.should == @deadline.due
      end
    end

    describe '#due=' do
      it 'should set the due date for the associated Deadline' do
        time = DateTime.now  
        @deadline.due.should_not == time
        @task.due = time
        @task.due.should == time 
      end
    end

    describe '#complete' do
      it 'should return the complete date from the associated Deadline' do
        @task.complete.should == @deadline.complete
      end
    end

    describe '#complete=' do
      it 'should set the complete boolean for the associated Deadline' do
        @deadline.complete.should_not == true
        @task.complete = true
        @task.complete.should == true 
      end
    end

    describe '#assignee' do
      it 'should return a User to whom the task is assigned' do
        @task.assignee.should be_nil
        @task.assignee = @user
        @task.assignee.should == @user
        @task.assignee.should be_a_kind_of(User) 
      end
    end

    # todo not sure about this method
    describe '#unassign!' do
      it 'should unassign the Task and destroy the Assignment' do
        @task.assignee = @user
        @task.unassign!
        @task.assignment.should be_nil
        @task.assignee.should be_nil
      end
    end

    describe 'associated models including' do
      it 'Deadline should be destroyed on Task#destroy' do
        expect {
          @task.destroy
        }.to change(Deadline,:count).by(-1)
      end

      it 'Assignment should be destroyed on Task#destroy' do
        @task.assignment = Factory(:assignment)

        expect {
          @task.destroy
        }.to change(Assignment,:count).by(-1)
      end

    end
  end
end

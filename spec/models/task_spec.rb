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

    # describe '#complete' do
    #   it 'should return a User' do
    #   end
    # end

    # describe '#reminder' do
    #   it 'should return a User' do
    #   end
    # end

    # describe '#reminds=' do
    #   it 'should return a User' do
    #   end
    # end

  end
end

require 'spec_helper'

describe Assignment do
  before(:each) do
    @user = Factory(:user)
    @task = Factory(:task)
    @watching = Factory(:assignment)
  end

  describe '#assignee=/assignee' do
    it 'should save a user' do
      @watching.assignee = @user
      @watching.assignee.should == @user
    end
  end

  describe '#entity=/entity' do
    it 'should save an entity' do
      @watching.entity = @task
      @watching.entity.should == @task
    end
  end
end

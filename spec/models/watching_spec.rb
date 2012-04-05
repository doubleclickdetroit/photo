require 'spec_helper'

describe Watching do
  before(:each) do
    @user = Factory(:user)
    @task = Factory(:task)
    @watching = Factory(:watching)
  end

  describe '#user=/user' do
    it 'should save a user' do
      @watching.user = @user
      @watching.user.should == @user
    end
  end

  describe '#entity=/entity' do
    it 'should save an entity' do
      @watching.entity = @task
      @watching.entity.should == @task
    end
  end

  describe '#group' do
    it 'should be delegated to #entity' do
      @watching.stub(:entity).and_return(Factory(:entity))
      @watching.entity.should_receive(:group)
      @watching.group
    end
  end

  describe '#to_hash' do
    it 'should simply return #attributes' do
      @watching.to_hash.should == @watching.attributes
    end
  end

  # describe '#assign!' do
  #   it 'should set assigned=true' do
  #     @watching1 = Factory(:watching, :assigned => false)
  #     @watching1.assigned.should be_false
  #     @watching1.assign!
  #     @watching1.assigned.should be_true
  #   end
  # end

  # describe '#unassign!' do
  #   it 'should set assigned=false' do
  #     @watching1 = Factory(:watching, :assigned => true)
  #     @watching1.assigned.should be_true
  #     @watching1.unassign!
  #     @watching1.assigned.should be_false
  #   end
  # end

  # describe '#assignments' do
  #   it 'should scope to assigned=true Watchings' do
  #     @watching.assigned = false
  #     @watching.save
  #     @watching1 = Factory(:watching, :assigned => true)
  #     Watching.assignments.should == [@watching1]
  #   end
  # end
end

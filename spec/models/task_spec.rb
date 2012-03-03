require 'spec_helper'

describe Task do
  before(:each) do
    @user = Factory(:user)
    @task = Factory(:task)
    # @task.assignment = Assignment.create(
    #                       :assignee_id     => @user.id,
    #                       :assignable_id   => @task.id,
    #                       :assignable_type => Entity.to_s)
  end

  describe '#assignee' do
    it 'should return a User' do
    end
  end

  describe '#assign_to' do
    it 'should return a User' do
    end
  end

  describe '#complete' do
    it 'should return a User' do
    end
  end

  describe '#reminder' do
    it 'should return a User' do
    end
  end

  describe '#reminds=' do
    it 'should return a User' do
    end
  end

end

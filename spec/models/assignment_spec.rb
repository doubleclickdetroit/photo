require 'spec_helper'

describe Assignment do
  before(:each) do
    @user = Factory(:user)
    # @assignment = Assignment.new
    @assignment = Factory(:assignment)
  end

  describe '#assignee and #assignee=' do
    it 'should save a user as the assignee' do
      @assignment.assignee = @user
      @assignment.assignee.should = @user
    end
  end
end

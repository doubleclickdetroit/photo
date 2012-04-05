require 'spec_helper'

describe Comment do
  before(:each) { @comment = Factory(:comment) }

  describe '#group' do
    it 'should be delegated to #entity' do
      @comment.stub(:entity).and_return(Factory(:entity))
      @comment.entity.should_receive(:group)
      @comment.group
    end
  end

  describe '#to_hash' do
    it 'should just return its attributes as a Hash' do
      @comment.to_hash.should == @comment.attributes
    end
  end
end

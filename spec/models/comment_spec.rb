require 'spec_helper'

describe Comment do
  before(:each) { @comment = Factory(:comment) }

  describe '#to_hash' do
    it 'should just return its attributes as a Hash' do
      @comment.to_hash.should == @comment.attributes
    end
  end
end

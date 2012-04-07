require 'spec_helper'

describe Duration do
  before(:each) do 
    @duration = Factory(:duration) 
    @entity   = Factory(:entity) 
  end

  describe '.entity' do
    it 'should do an AR r/w' do
      @duration.entity = @entity
      @duration.entity.should == @entity
    end
  end
end

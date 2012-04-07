require 'spec_helper'

describe Location do
  before(:each) do 
    @location = Factory(:location) 
    @entity   = Factory(:entity) 
  end

  describe '.entity' do
    it 'should do an AR r/w' do
      @location.entity = @entity
      @location.entity.should == @entity
    end
  end
end

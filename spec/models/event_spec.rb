require 'spec_helper'

describe Entity do
  describe Event do
    before(:each) do
      @event    = Factory(:event)
      @location = Factory(:location)
      @event.location = @location
      @event.reload
    end

    describe '#location_line1/location_line2' do
      it 'should delegate r/w to Location' do
        @event.location_line1.should == @location.line1
        @event.location_line2.should == @location.line2
      end
    end

    describe '#attendees methods' do
      it 'should simply be an alias to #followers' do
        pending 'messed up association thing...'
        # @event.followers
        # @event.attendees = [Factory(:user)]
        # @event.attendees << Factory(:user)
        # @event.attendees.should == @event.followers
      end
    end
  end
end

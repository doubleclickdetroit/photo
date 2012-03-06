require 'spec_helper'

describe Entity do
  describe Event do
    before(:each) do
      @event     = Factory(:event)
      @time_place = Factory(:time_place)
      @event.time_place = @time_place
      @event.reload
    end

    describe '#start' do
      it 'should be delegated to TimePlace' do
        time = Time.new
        @event.start = time
        @event.start.should == time
      end
    end

    describe '#finish' do
      it 'should be delegated to TimePlace' do
        time = Time.new
        @event.finish = time
        @event.finish.should == time
      end
    end

    describe '#location_line1/location_line2' do
      it 'should delegate r/w to #time_place' do
        @event.address1.should == @time_place.address1
        @event.address2.should == @time_place.address2
      end
    end

    describe '#attendees methods' do
      it 'should simply be an alias to #followers' do
        @event.attendees = [Factory(:user)]
        @event.attendees << Factory(:user)
        @event.attendees.should == @event.followers
      end
    end
  end
end

require 'spec_helper'

describe Entity do
  describe Event do
    before(:each) do
      @event      = Factory(:event)
      # @time_place = Factory(:time_place)
      # @event.time_place = @time_place
    end

    # describe '.time_place' do
    #   subject { @event.time_place }

    #   it { should be_an_instance_of TimePlace }
    # end

    # describe '#start' do
    #   it 'should be delegated to TimePlace' do
    #     time = Time.new
    #     @event.start = time
    #     @event.start.should == time
    #   end
    # end

    # describe '#finish' do
    #   it 'should be delegated to TimePlace' do
    #     time = Time.new
    #     @event.finish = time
    #     @event.finish.should == time
    #   end
    # end

    # describe '#address[1/2/3]' do
    #   it 'should delegate r/w to #time_place' do
    #     @event.address1.should == @time_place.address1
    #     @event.address2.should == @time_place.address2
    #     @event.address3.should == @time_place.address3
    #   end
    # end

    # describe '#attendees methods' do
    #   it 'should simply be an alias to #followers' do
    #     @event.attendees = [Factory(:user)]
    #     @event.attendees << Factory(:user)
    #     @event.attendees.should == @event.followers
    #   end
    # end
  end
end

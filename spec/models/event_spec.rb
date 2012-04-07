require 'spec_helper'

describe Entity do
  describe Event do
    before(:each) do
      @event      = Factory(:event, :with_association)
      @time_place = @event.time_place
      @duration   = @event.duration
      @location   = @event.location
    end

    describe '#attendees methods' do
      it 'should simply be an alias to #followers' do
        @event.attendees = [Factory(:user)]
        @event.attendees << Factory(:user)
        @event.attendees.should == @event.followers
      end
    end

    describe '.duration' do
      subject { @event.duration }
      it { should be_an_instance_of Duration }

      it 'should be destroyed on Event#destroy' do
        expect {
          @event.destroy
        }.to change(Duration,:count).by(-1)
      end

      describe '#start' do
        it 'should be delegated to Duration' do
          time = Time.new
          @duration.should_receive :start=
          @event.start = time
        end
      end

      describe '#finish' do
        it 'should be delegated to Duration' do
          time = Time.new
          @duration.should_receive :finish=
          @event.finish = time
        end
      end
    end

    describe '.location' do
      subject { @event.location }
      it { should be_an_instance_of Location }

      it 'should be destroyed on Event#destroy' do
        expect {
          @event.destroy
        }.to change(Location,:count).by(-1)
      end

      describe '#address[1/2/3]' do
        it 'should be delegated to #location' do
          @location.should_receive :address1
          @location.should_receive :address2
          @location.should_receive :address3

          @event.address1
          @event.address2
          @event.address3
        end
      end
    end
  end
end

require 'spec_helper'

describe Entity do
  describe Embed do
    before(:each) do
      @embed = Factory(:embed)
      @asset = Factory(:asset)
      @embed.file = Rails.root.join('app','assets','images','avatar.png').open
    end

    describe '#asset' do
      it 'should create an asset after_save' do
        # having assigned nothing outright...
        @embed.asset.should be_a_kind_of(Asset)
      end
    end

    describe '#file/#file_name' do
      it 'should accept a file upload and return the filename' do
        @embed.file_name.should == 'avatar.png'
      end
    end

    describe '#content_type' do
      it 'should accept a file upload' do
        @embed.content_type.should == 'image/png'
      end
    end

    describe '#url' do
      it 'should be delegated to #asset.attachment.url' do
        @embed.url.should match(/system.*#{@embed.file_name}/)
      end
    end
  end
end

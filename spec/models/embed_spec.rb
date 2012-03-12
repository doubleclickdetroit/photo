require 'spec_helper'

describe Entity do
  describe Embed do
    before(:each) do
      @embed = Factory(:embed)
      @asset = Factory(:asset)
      @embed.asset.file = Rails.root.join('app','assets','images','avatar.png').open
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

    describe '#to_hash' do
      it 'should have attributes of associated models for Task' do
        keys = %w(file_name file_size content_type url)
        (@embed.to_hash.keys & keys).should == keys
      end
    end
  end
end

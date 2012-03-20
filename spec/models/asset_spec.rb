require 'spec_helper'

describe Asset do
  before(:each) { @asset = Factory(:asset) }

  describe '#url' do
    it 'should be delegated to file' do
      @asset.file.should_receive :url
      @asset.url
    end
  end

  describe '#file_name' do
    it 'should call #file_file_name' do
      @asset.should_receive :file_file_name
      @asset.file_name
    end
  end

  describe '#file_size' do
    it 'should call #file_file_size' do
      @asset.should_receive :file_file_size
      @asset.file_size
    end
  end

  describe '#content_type' do
    it 'should call #file_content_type' do
      @asset.should_receive :file_content_type
      @asset.content_type
    end
  end

  describe '#url' do
    it 'should call #file_url' do
      @asset.should_receive :file_url
      @asset.url
    end
  end
end

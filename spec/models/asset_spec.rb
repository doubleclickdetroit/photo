# require 'spec_helper'
# 
# describe Entity do
#   describe Embed do
#     before(:each) do
#       @embed = Factory(:embed)
#       @asset = Factory(:asset)
#     end
# 
#     describe '#asset' do
#       it 'has_one Asset' do
#         @embed.asset = @asset
#         @embed.reload.asset.should == @asset
#       end
#     end
# 
#     describe '#file' do
#       it 'should accept a file upload' do
#         @embed.file = Rails.root.join('app','assets','images','avatar.png').open
#         # @asset.attachment = fixture_file_upload(Rails.root.join('avatar.png'), 'image/png')
#       end
# 
#       it 'should generate the appropriate file icons depending on the file type' do
#       end
# 
#       describe '#url' do
#         it 'should return the path to the file' do
#         end
#       end
#     end
#   end
# end

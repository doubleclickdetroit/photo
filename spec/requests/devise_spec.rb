require 'spec_helper'
require 'uri'

describe 'Devise' do
  describe 'HTTP Auth' do
    before(:each) { @user = Factory(:user) }

    describe "sign in" do
      it "returns success" do
        pending

        # uri = URI(user_session_url)

        # req = Net::HTTP::Get.new(uri.request_uri)
        # req.basic_auth @user.email, @user.password 

        # res = Net::HTTP.start(uri.host, uri.port) {|http|
        #   http.request(req)
        # }
        # puts res.body

        # str  = "#{@user.email}:#{@user.password}"
        # pair = URI.unescape(CGI::escape(Base64.decode64(str)))
        # # header 'Authorization', "Basic  #{pair}"
        # post user_session_url, {"Authorization" => "Basic  #{@user.email + ":" + @user.password}"} 
        response.should contain('Signed in successfully')
      end
    end
  end

  it 'premits login by user.name' 
end

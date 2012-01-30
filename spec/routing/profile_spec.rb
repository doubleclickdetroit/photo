require 'spec_helper'

describe "routing to profiles" do
  it "does not expose a list of profiles" do
    pending
    { :get => "/profiles" }.should_not be_routable
  end

  it "routes /profile/:username to profile#show for username" do
    pending
    { :get => "/profiles/jsmith" }.should route_to(
      :controller => "profiles",
      :action => "show",
      :username => "jsmith"
    )
  end
end

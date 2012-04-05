require "spec_helper"

describe InvitationsController do
  describe "routing" do
    it "routes to #create" do
      post("/api/groups/1/invitations").should route_to("invitations#create", :group_id => "1")
    end

    it "routes to #index" do
      get("/api/groups/1/invitations/").should route_to("invitations#index", :group_id => "1")
    end

    it "routes to #show" do
      get("/api/groups/1/invitations/2").should route_to("invitations#show", :id => "2", :group_id => "1")
    end

    it "routes to #destroy" do
      delete("/api/groups/1/invitations/2").should route_to("invitations#destroy", :id => "2", :group_id => "1")
    end
  end
end

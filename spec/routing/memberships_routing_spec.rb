require "spec_helper"

describe MembershipsController do
  describe "routing" do
    # todo dont need new/edit
    # todo dont think i need index/show/update

    it "routes to #create" do
      post("/api/memberships").should route_to("memberships#create")
    end

    it "routes to #destroy" do
      delete("/api/memberships/1").should route_to("memberships#destroy", :id => "1")
    end

    # it "routes to #index" do
    #   get("/api/memberships").should_not route_to("memberships#index")
    # end

    # it "routes to #show" do
    #   get("/api/memberships/1").should_not route_to("memberships#show", :id => "1")
    # end

    # it "routes to #update" do
    #   put("/api/memberships/1").should_not route_to("memberships#update", :id => "1")
    # end

    # it "does not route to #new" do
    #   get("/api/memberships/1/new").should_not route_to("memberships#new")
    # end

    # it "does not route to #edit" do
    #   get("/api/memberships/1/edit").should_not route_to("memberships#edit")
    # end

  end
end

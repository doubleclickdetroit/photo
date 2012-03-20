require "spec_helper"

describe GroupsController do
  describe "routing" do

    it "routes to #index" do
      get("/api/groups").should route_to("groups#index")
    end

    it "routes to #new" do
      get("/api/groups/new").should route_to("groups#new")
    end

    it "routes to #show" do
      get("/api/groups/1").should route_to("groups#show", :id => "1")
    end

    it "routes to #edit" do
      get("/api/groups/1/edit").should route_to("groups#edit", :id => "1")
    end

    it "routes to #create" do
      post("/api/groups").should route_to("groups#create")
    end

    it "routes to #update" do
      put("/api/groups/1").should route_to("groups#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/api/groups/1").should route_to("groups#destroy", :id => "1")
    end

  end
end

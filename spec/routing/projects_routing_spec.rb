require "spec_helper"

describe ProjectsController do
  describe "routing" do

    describe "for projects only" do
      it "routes to #index" do
        get("/api/projects").should route_to("projects#index")
      end

      it "routes to #new" do
        get("/api/projects/new").should route_to("projects#new")
      end

      it "routes to #show" do
        get("/api/projects/1").should route_to("projects#show", :id => "1")
      end

      it "routes to #edit" do
        get("/api/projects/1/edit").should route_to("projects#edit", :id => "1")
      end

      it "routes to #create" do
        post("/api/projects").should route_to("projects#create")
      end

      it "routes to #update" do
        put("/api/projects/1").should route_to("projects#update", :id => "1")
      end

      it "routes to #destroy" do
        delete("/api/projects/1").should route_to("projects#destroy", :id => "1")
      end
    end

    describe "for projects by group" do
      it "routes to #index" do
        get("/api/groups/1/projects").should route_to("projects#index", :group_id => "1")
      end

      it "routes to #show" do
        get("/api/groups/1/projects/2").should route_to("projects#show", :id => "2", :group_id => "1")
      end

      it "routes to #create" do
        post("/api/groups/1/projects").should route_to("projects#create", :group_id => "1")
      end

      it "routes to #update" do
        put("/api/groups/1/projects/2").should route_to("projects#update", :id => "2", :group_id => "1")
      end

      it "routes to #destroy" do
        delete("/api/groups/1/projects/2").should route_to("projects#destroy", :id => "2", :group_id => "1")
      end

      # it "routes to #new" do
      #   get("/api/groups/1/projects/new").should route_to("projects#new", :group_id => "1")
      # end

      # it "routes to #edit" do
      #   get("/api/groups/1/projects/2/edit").should route_to("projects#edit", :id => "2", :group_id => "1")
      # end
    end

  end
end

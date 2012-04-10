require "spec_helper"

describe PhasesController do
  describe "routing" do

    describe "for phases only" do
      # it "routes to #index" do
      #   get("/api/phases").should route_to("phases#index")
      # end

      # it "routes to #show" do
      #   get("/api/phases/1").should route_to("phases#show", :id => "1")
      # end

      it "routes to #create" do
        post("/api/phases").should route_to("phases#create")
      end

      it "routes to #update" do
        put("/api/phases/1").should route_to("phases#update", :id => "1")
      end

      it "routes to #destroy" do
        delete("/api/phases/1").should route_to("phases#destroy", :id => "1")
      end

      # it "routes to #new" do
      #   get("/api/phases/new").should route_to("phases#new")
      # end

      # it "routes to #edit" do
      #   get("/api/phases/1/edit").should route_to("phases#edit", :id => "1")
      # end
    end

    describe "for phases by project" do
      # it "routes to #index" do
      #   get("/api/projects/1/phases").should route_to("phases#index", :project_id => "1")
      # end

      # it "routes to #show" do
      #   get("/api/projects/1/phases/2").should route_to("phases#show", :id => "2", :project_id => "1")
      # end

      it "routes to #create" do
        post("/api/projects/1/phases").should route_to("phases#create", :project_id => "1")
      end

      it "routes to #update" do
        put("/api/projects/1/phases/2").should route_to("phases#update", :id => "2", :project_id => "1")
      end

      it "routes to #destroy" do
        delete("/api/projects/1/phases/2").should route_to("phases#destroy", :id => "2", :project_id => "1")
      end

      # it "routes to #new" do
      #   get("/api/projects/1/phases/new").should route_to("phases#new", :project_id => "1")
      # end

      # it "routes to #edit" do
      #   get("/api/projects/1/phases/2/edit").should route_to("phases#edit", :id => "2", :project_id => "1")
      # end
    end

  end
end

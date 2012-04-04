require "spec_helper"

describe CommentsController do
  describe "routing" do
  
    it "routes to #create" do
      post("/api/entities/1/comments").should route_to("comments#create", :entity_id => "1")
    end

    it "routes to #update" do
      put("/api/entities/1/comments/2").should route_to("comments#update", :id => "2", :entity_id => "1")
    end

    it "routes to #destroy" do
      delete("/api/entities/1/comments/2").should route_to("comments#destroy", :id => "2", :entity_id => "1")
    end

  end
end

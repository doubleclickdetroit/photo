require "spec_helper"

describe WatchingsController do
  describe "routing" do
  
    it "routes to #create" do
      post("/api/entities/1/watchings").should route_to("watchings#create", :entity_id => "1")
    end

    it "routes to #destroy" do
      delete("/api/entities/1/watchings/2").should route_to("watchings#destroy", :id => "2", :entity_id => "1")
    end

  end
end

require "spec_helper"

describe EntitiesController do
  describe 'vanilla Entity routing' do
    it "routes to #index" do
      get("/api/phases/1/entities").should route_to("entities#index", :phase_id => "1")
    end

    it "routes to #show" do
      get("/api/phases/1/entities/2").should route_to("entities#show", :phase_id => "1", :id => "2")
    end
  end

  describe "subclass routing" do

    Entity::TYPES.each do |klass|
      describe "for #{klass.to_s}" do
        let(:klass_str) { klass.to_s.pluralize.downcase }
        let(:type_str) { klass.to_s }

        it "routes to #index" do
          get("/api/phases/1/#{klass_str}").should route_to("entities#index", :type => type_str, :phase_id => "1")
        end

        it "routes to #show" do
          get("/api/phases/1/#{klass_str}/2").should route_to("entities#show", :id => "2", :type => type_str, :phase_id => "1")
        end

        it "routes to #create" do
          post("/api/phases/1/#{klass_str}").should route_to("entities#create", :type => type_str, :phase_id => "1")
        end

        it "routes to #update" do
          put("/api/phases/1/#{klass_str}/2").should route_to("entities#update", :id => "2", :type => type_str, :phase_id => "1")
        end

        it "routes to #destroy" do
          delete("/api/phases/1/#{klass_str}/2").should route_to("entities#destroy", :id => "2", :type => type_str, :phase_id => "1")
        end
      end
    end

  end
end

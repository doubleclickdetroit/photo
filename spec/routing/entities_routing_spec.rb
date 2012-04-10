require "spec_helper"

describe EntitiesController do
  describe "routing" do
  
    describe 'for Task' do
      it "routes to #index" do
        get("/api/phases/1/tasks").should route_to("entities#index", :type => 'Task', :phase_id => "1")
      end

      it "routes to #show" do
        get("/api/phases/1/tasks/2").should route_to("entities#show", :id => "2", :type => 'Task', :phase_id => "1")
      end

      it "routes to #create" do
        post("/api/phases/1/tasks").should route_to("entities#create", :type => 'Task', :phase_id => "1")
      end

      it "routes to #update" do
        put("/api/phases/1/tasks/2").should route_to("entities#update", :id => "2", :type => 'Task', :phase_id => "1")
      end

      it "routes to #destroy" do
        delete("/api/phases/1/tasks/2").should route_to("entities#destroy", :id => "2", :type => 'Task', :phase_id => "1")
      end

      # it "routes to #new" do
      #   get("/api/phases/1/tasks/new").should route_to("entities#new", :type => 'Task', :phase_id => "1")
      # end

      # it "routes to #edit" do
      #   get("/api/phases/1/tasks/2/edit").should route_to("entities#edit", :id => "2", :type => 'Task', :phase_id => "1")
      # end
    end

    describe 'for Event' do
      it "routes to #index" do
        get("/api/phases/1/events").should route_to("entities#index", :type => 'Event', :phase_id => "1")
      end

      it "routes to #show" do
        get("/api/phases/1/events/2").should route_to("entities#show", :id => "2", :type => 'Event', :phase_id => "1")
      end

      it "routes to #create" do
        post("/api/phases/1/events").should route_to("entities#create", :type => 'Event', :phase_id => "1")
      end

      it "routes to #update" do
        put("/api/phases/1/events/2").should route_to("entities#update", :id => "2", :type => 'Event', :phase_id => "1")
      end

      it "routes to #destroy" do
        delete("/api/phases/1/events/2").should route_to("entities#destroy", :id => "2", :type => 'Event', :phase_id => "1")
      end

      # it "routes to #edit" do
      #   get("/api/phases/1/events/2/edit").should route_to("entities#edit", :id => "2", :type => 'Event', :phase_id => "1")
      # end

      # it "routes to #new" do
      #   get("/api/phases/1/events/new").should route_to("entities#new", :type => 'Event', :phase_id => "1")
      # end
    end

    describe 'for Embed' do
      it "routes to #index" do
        get("/api/phases/1/embeds").should route_to("entities#index", :type => 'Embed', :phase_id => "1")
      end

      it "routes to #show" do
        get("/api/phases/1/embeds/2").should route_to("entities#show", :id => "2", :type => 'Embed', :phase_id => "1")
      end

      it "routes to #create" do
        post("/api/phases/1/embeds").should route_to("entities#create", :type => 'Embed', :phase_id => "1")
      end

      it "routes to #update" do
        put("/api/phases/1/embeds/2").should route_to("entities#update", :id => "2", :type => 'Embed', :phase_id => "1")
      end

      it "routes to #destroy" do
        delete("/api/phases/1/embeds/2").should route_to("entities#destroy", :id => "2", :type => 'Embed', :phase_id => "1")
      end

      # it "routes to #new" do
      #   get("/api/phases/1/embeds/new").should route_to("entities#new", :type => 'Embed', :phase_id => "1")
      # end

      # it "routes to #edit" do
      #   get("/api/phases/1/embeds/2/edit").should route_to("entities#edit", :id => "2", :type => 'Embed', :phase_id => "1")
      # end
    end

    # describe 'vanilla Entity by phase' do
    #   it "routes to #index" do
    #     get("/api/phases/1/entities").should route_to("entities#index", :phase_id => "1")
    #   end

    #   it "routes to #new" do
    #     get("/api/phases/1/entities/new").should route_to("entities#new", :phase_id => "1")
    #   end

    #   it "routes to #show" do
    #     get("/api/phases/1/entities/2").should route_to("entities#show", :id => "2", :phase_id => "1")
    #   end

    #   it "routes to #edit" do
    #     get("/api/phases/1/entities/2/edit").should route_to("entities#edit", :id => "2", :phase_id => "1")
    #   end

    #   it "routes to #create" do
    #     post("/api/phases/1/entities").should route_to("entities#create", :phase_id => "1")
    #   end

    #   it "routes to #update" do
    #     put("/api/phases/1/entities/2").should route_to("entities#update", :id => "2", :phase_id => "1")
    #   end

    #   it "routes to #destroy" do
    #     delete("/api/phases/1/entities/2").should route_to("entities#destroy", :id => "2", :phase_id => "1")
    #   end
    # end

  end
end

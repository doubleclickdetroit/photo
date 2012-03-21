require "spec_helper"

describe EntitiesController do
  describe "routing" do
  
    describe 'for Task' do
      it "routes to #index" do
        get("/api/projects/1/tasks").should route_to("entities#index", :type => 'Task', :project_id => "1")
      end

      it "routes to #show" do
        get("/api/projects/1/tasks/2").should route_to("entities#show", :id => "2", :type => 'Task', :project_id => "1")
      end

      it "routes to #create" do
        post("/api/projects/1/tasks").should route_to("entities#create", :type => 'Task', :project_id => "1")
      end

      it "routes to #update" do
        put("/api/projects/1/tasks/2").should route_to("entities#update", :id => "2", :type => 'Task', :project_id => "1")
      end

      it "routes to #destroy" do
        delete("/api/projects/1/tasks/2").should route_to("entities#destroy", :id => "2", :type => 'Task', :project_id => "1")
      end

      # it "routes to #new" do
      #   get("/api/projects/1/tasks/new").should route_to("entities#new", :type => 'Task', :project_id => "1")
      # end

      # it "routes to #edit" do
      #   get("/api/projects/1/tasks/2/edit").should route_to("entities#edit", :id => "2", :type => 'Task', :project_id => "1")
      # end
    end

    describe 'for Event' do
      it "routes to #index" do
        get("/api/projects/1/events").should route_to("entities#index", :type => 'Event', :project_id => "1")
      end

      it "routes to #show" do
        get("/api/projects/1/events/2").should route_to("entities#show", :id => "2", :type => 'Event', :project_id => "1")
      end

      it "routes to #create" do
        post("/api/projects/1/events").should route_to("entities#create", :type => 'Event', :project_id => "1")
      end

      it "routes to #update" do
        put("/api/projects/1/events/2").should route_to("entities#update", :id => "2", :type => 'Event', :project_id => "1")
      end

      it "routes to #destroy" do
        delete("/api/projects/1/events/2").should route_to("entities#destroy", :id => "2", :type => 'Event', :project_id => "1")
      end

      # it "routes to #edit" do
      #   get("/api/projects/1/events/2/edit").should route_to("entities#edit", :id => "2", :type => 'Event', :project_id => "1")
      # end

      # it "routes to #new" do
      #   get("/api/projects/1/events/new").should route_to("entities#new", :type => 'Event', :project_id => "1")
      # end
    end

    describe 'for Embed' do
      it "routes to #index" do
        get("/api/projects/1/embeds").should route_to("entities#index", :type => 'Embed', :project_id => "1")
      end

      it "routes to #show" do
        get("/api/projects/1/embeds/2").should route_to("entities#show", :id => "2", :type => 'Embed', :project_id => "1")
      end

      it "routes to #create" do
        post("/api/projects/1/embeds").should route_to("entities#create", :type => 'Embed', :project_id => "1")
      end

      it "routes to #update" do
        put("/api/projects/1/embeds/2").should route_to("entities#update", :id => "2", :type => 'Embed', :project_id => "1")
      end

      it "routes to #destroy" do
        delete("/api/projects/1/embeds/2").should route_to("entities#destroy", :id => "2", :type => 'Embed', :project_id => "1")
      end

      # it "routes to #new" do
      #   get("/api/projects/1/embeds/new").should route_to("entities#new", :type => 'Embed', :project_id => "1")
      # end

      # it "routes to #edit" do
      #   get("/api/projects/1/embeds/2/edit").should route_to("entities#edit", :id => "2", :type => 'Embed', :project_id => "1")
      # end
    end

    # describe 'vanilla Entity by project' do
    #   it "routes to #index" do
    #     get("/api/projects/1/entities").should route_to("entities#index", :project_id => "1")
    #   end

    #   it "routes to #new" do
    #     get("/api/projects/1/entities/new").should route_to("entities#new", :project_id => "1")
    #   end

    #   it "routes to #show" do
    #     get("/api/projects/1/entities/2").should route_to("entities#show", :id => "2", :project_id => "1")
    #   end

    #   it "routes to #edit" do
    #     get("/api/projects/1/entities/2/edit").should route_to("entities#edit", :id => "2", :project_id => "1")
    #   end

    #   it "routes to #create" do
    #     post("/api/projects/1/entities").should route_to("entities#create", :project_id => "1")
    #   end

    #   it "routes to #update" do
    #     put("/api/projects/1/entities/2").should route_to("entities#update", :id => "2", :project_id => "1")
    #   end

    #   it "routes to #destroy" do
    #     delete("/api/projects/1/entities/2").should route_to("entities#destroy", :id => "2", :project_id => "1")
    #   end
    # end

  end
end

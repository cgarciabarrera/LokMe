require "spec_helper"

describe SharedsController do
  describe "routing" do

    it "routes to #index" do
      get("/shareds").should route_to("shareds#index")
    end

    it "routes to #new" do
      get("/shareds/new").should route_to("shareds#new")
    end

    it "routes to #show" do
      get("/shareds/1").should route_to("shareds#show", :id => "1")
    end

    it "routes to #edit" do
      get("/shareds/1/edit").should route_to("shareds#edit", :id => "1")
    end

    it "routes to #create" do
      post("/shareds").should route_to("shareds#create")
    end

    it "routes to #update" do
      put("/shareds/1").should route_to("shareds#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/shareds/1").should route_to("shareds#destroy", :id => "1")
    end

  end
end

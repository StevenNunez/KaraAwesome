require 'rails_helper'

RSpec.describe SearchController, :type => :controller do

  describe "GET 'index'" do
    it "does not run search if no parameters given" do
      get 'index'
      results = assigns(:results)
      expect(results).to be_nil
    end

    it "searches for videos if parameters given" do
      get 'index', q: "Beastie Boys Sabotage"
      results = assigns(:results)
      expect(results).to_not be_nil
    end
  end

end

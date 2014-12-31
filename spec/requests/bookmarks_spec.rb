require 'rails_helper'

RSpec.describe "Bookmarks", :type => :request do
  describe "GET /bookmarks" do
    it "works! (now write some real specs)" do
      get bookmarks_path
      expect(response.status).to be(200)
    end
  end
end

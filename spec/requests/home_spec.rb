require 'spec_helper'

describe 'Home' do
  describe "GET Homepage" do
    it "responds successfully with an HTTP 200 status code" do
      get root_path
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get root_path
      expect(response).to render_template("index")
    end
    #it "should have the content 'Hello world'" do
    #  visit '/home/index'
    #  page.should have_selector('h1', text: 'Hello world')
    #end
  end
end
require 'spec_helper'

describe SitemapController do
  
  before(:each) do
    @posts = [mock_model(Post, :slug => "my_post", :id => 1, :published_at => Time.utc(2009,1,1))]
    Post.stub!(:all).and_return(@posts)
    @pages = [mock_model(Page, :slug => "my_page", :id => 2, :published_at => Time.utc(2009,1,1))]
    Page.stub!(:all).and_return(@pages)
  end

  describe 'handling GET to index' do
    
    def do_get
      get :index
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should generate correct sitemap" do
      do_get
      response.body.should == File.read("#{RAILS_ROOT}/spec/fixtures/sitemap.xml")
    end

  end

end

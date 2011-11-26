class SitemapController < ApplicationController
  
  def index
    posts = Post.all
    pages = Page.all
    xml = Builder::XmlMarkup.new(:indent=>2)
    xml.instruct!
    xml.urlset "xmlns" => "http://www.google.com/schemas/sitemap/0.84", "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance", "xsi:schemaLocation" => "http://www.google.com/schemas/sitemap/0.84 http://www.google.com/schemas/sitemap/0.84/sitemap.xsd" do
      posts.each do |post|
        xml.url do
          xml.loc "http://#{request.host_with_port}#{sitemap_post_path(post)}"
          xml.changefreq 'weekly'
          xml.priority 1.0
        end
      end

      pages.each do |post|
        xml.url do
          xml.loc "http://#{request.host_with_port}/pages/#{post.slug}"
          xml.changefreq 'weekly'
          xml.priority 0.8
        end
      end
    end
    render :xml => xml.target!
  end
  
  def sitemap_post_path(post, options = {})
    suffix = options[:anchor] ? "##{options[:anchor]}" : ""
    path = post.published_at.strftime("/%Y/%m/%d/") + post.slug + suffix
    path = URI.join(config[:url], path) if options[:only_path] == false
    path.untaint
  end
  
  
end

require "rubygems"
require "test/unit"
require "rack/test"
require "blog"

class ConfigTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Blog.new.to_app
  end

  def test_blog_title_is_compactcode
    get "/"
    assert last_response.body.include?("<title>compactcode</title>")
  end

end
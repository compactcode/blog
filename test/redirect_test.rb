require "rubygems"
require 'bundler/setup'
require "test/unit"
require "rack/test"
require "blog"

class RedirectTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Blog.new.to_app
  end

  def test_index_page_renders
    get "/"
    assert last_response.ok?
  end

  def test_old_wordpress_rss_feed_is_redirected
    get "/feed/"
    follow_redirect!
    assert_equal "http://example.org/index.xml", last_request.url
  end

  def test_old_wordpress_rss_feed_without_trailing_slash_is_redirected
    get "/feed"
    follow_redirect!
    assert_equal "http://example.org/index.xml", last_request.url
  end

  def test_old_wordpress_articles_are_redirected
    get "/2009/09/introducing-compaction/"
    follow_redirect!
    assert_equal "http://compacted.wordpress.com/2009/09/introducing-compaction/", last_request.url
  end

  def test_all_old_wordpress_articles_are_redirected
    get "/2010/04/google-collections-made-easier/"
    follow_redirect!
    assert_equal "http://compacted.wordpress.com/2010/04/google-collections-made-easier/", last_request.url
  end

  def test_older_wordpress_articles_are_redirected
    get "/2009/09/introducing-compaction/"
    follow_redirect!
    assert_equal "http://compacted.wordpress.com/2009/09/introducing-compaction/", last_request.url
  end

  def test_very_old_wordpress_articles_are_redirected
    get "/index.php/2009/09/introducing-compaction/"
    follow_redirect!
    assert_equal "http://compacted.wordpress.com/2009/09/introducing-compaction/", last_request.url
  end

end
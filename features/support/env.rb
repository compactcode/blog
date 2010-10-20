# Generated by cucumber-sinatra. (Tue Oct 19 22:23:34 +1100 2010)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'blog.rb')

require 'capybara'
require 'capybara/cucumber'
require 'spec'

Capybara.default_selector = :css
Capybara.app = Blog.new.to_app


class BlogWorld
  include Capybara
  include Spec::Expectations
  include Spec::Matchers
end

World do
  BlogWorld.new
end
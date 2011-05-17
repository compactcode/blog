require 'rubygems'
require 'bundler/setup'

require 'toto'
require 'rack-rewrite'

class Blog
  def to_app
    Rack::Builder.new {
      use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
      use Rack::CommonLogger

      use Rack::Rewrite do
        r301 '/feed',             '/index.xml'
        r301 '/feed/',            '/index.xml'
        r301 %r{/index.php/(.*)}, 'http://compacted.wordpress.com/$1'
        r301 %r{/2010/04/(.*)},   'http://compacted.wordpress.com/2010/04/$1'
        r301 %r{/2009/(.*)},      'http://compacted.wordpress.com/2009/$1'
      end
      
      toto = Toto::Server.new do
        set :author, "Shanon McQuay"
        set :title,  "compactcode"
        set :url,    "compactcode.com"
        set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
      end

      run toto
    }.to_app
  end
end
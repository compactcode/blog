require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

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
      
      use Rack::Codehighlighter, :ultraviolet, :markdown => true, :element => "pre>code", :pattern => /\A:::(\w+)\s*\n/, :theme => "twilight"
      
      toto = Toto::Server.new do
        set :author, "Shanon McQuay"
        set :title,  "compactcode"
        set :url,    "compactcode.com"
        set :date,   lambda { |now| now } # Prevent date being converted into a string.
      end

      run toto
    }.to_app
  end
end

require 'json'
require './models.rb'

def start(opts)
  EM.run do
    server   = opts[:server] || 'thin'
    host     = opts[:host]   || '0.0.0.0'
    port     = opts[:port]   || '9393'
    web_app  = opts[:app]

    dispatch = Rack::Builder.app do
      map '/' do
        run web_app
      end
    end

    Rack::Server.start({
      app:    dispatch,
      server: server,
      Host:   host,
      Port:   port
    })
  end
end

class Blockout < Sinatra::Base

  configure do
    set :threaded, false
  end

  get '/' do
    "hello"
  end

  get '/stream' do
    @streamers = Streamer.where.stream
    erb :index
  end

  get '/delayed' do
    EM.defer do
      sleep 5
    end
    'I\'m doing work in the background, but I am still free to take requests'
  end
end

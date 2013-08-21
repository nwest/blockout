require 'json'

module EM
  def self.chan
    @channel ||= EM::Channel.new
  end
end

require './models.rb'

EM.run do
  class Blockout < Sinatra::Base
    configure do
      set :threaded, false
    end

    def name_gen
      base = ('a'..'z').to_a + ('A'..'Z').to_a + (1..9).to_a
      base.shuffle[0..12].join
    end

    get '/' do
      erb :index
    end

    get '/gen' do
      s = Streamer.create(name: name_gen)
      "created #{s.name}."
    end

    get '/touch' do
      s = Streamer[(1..Streamer.count).to_a.shuffle[0]]
      s.update(name: name_gen)
      "updated #{s.name}."
    end
  end

  EM::WebSocket.run(host: '0.0.0.0', port: 8181) do |ws|
    ws.onopen do 
      sid = EM.chan.subscribe { |msg| ws.send msg }
      puts "user #{sid} has connected."

      DB[:streamers].stream.each do |streamer|
        EM.chan.push streamer.to_json
      end
    end

    #ws.onmessage { |msg| EM.chan.push "Received #{msg}." }
    ws.onclose { puts "connection closed." }
  end

  Blockout.run! port: 9393
end

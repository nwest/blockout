require 'json'
require './models.rb'

class Blockout < Sinatra::Base
  if self.development?
    set :show_exceptions, true
    set :logging, true
  end

  get '/' do
    erb :index
  end
end

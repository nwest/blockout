require 'bundler'
Bundler.require
Dotenv.load

DB = Sequel::Model.db = Sequel.connect ENV['DATABASE_URL']
DB.extension :pg_streaming

if ENV['RACK_ENV'] == 'development'
  require 'logger'
  DB.loggers << Logger.new($stdout)
end

require './blockout'
#start app: Blockout.new

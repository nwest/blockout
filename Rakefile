require 'dotenv'
Dotenv.load

task :console do
  exec "bundle exec sequel -E $DATABASE_URL -r './models.rb'"
end
task :c => :console

namespace :db do
  require 'sequel'
  require 'logger'
  Sequel.extension :migration
  DB = Sequel.connect ENV['DATABASE_URL']
  DB.loggers << Logger.new($stdout)

  task :migrate do
    version = Sequel::Migrator.run(DB, './migrations', :use_transactions=>true)
    puts "db migrated to version #{version}."
  end

  task :reset do
    Sequel::Migrator.run(DB, './migrations', :use_transactions=>true, :target => 0)
    version = Sequel::Migrator.run(DB, './migrations', :use_transactions=>true)
    puts "db reset to version #{version}."
  end

  task :seed do
    require 'json'
    require './models.rb'

    def read_json_file(path)
      JSON.parse(IO.read(File.expand_path(path, File.dirname(__FILE__))), :symbolize_names => :true)
    end

  end

  task :reset_db do
    Rake::Task["db:reset"].invoke
    Rake::Task["db:seed"].invoke
  end
end

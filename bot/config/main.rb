require 'sqlite3'
require 'active_record'
require 'require_all'
require 'pry'
require 'yaml'
require 'alch'
require 'gingerice'
require 'recursive-open-struct'
require_all 'models'

# Read database.yml for connection info and connect to db
connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)

class Config
  attr_accessor :secrets

  def initialize
    @secrets = RecursiveOpenStruct.new(YAML::load(File.open('config/secrets.yml')))
  end
end






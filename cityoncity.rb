require 'rubygems'
require 'sinatra'
require 'data_mapper'


database connection
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class CityImages
    include DataMapper::Resource
    
    property :id, Serial
    property :city, String
    property :link, URI
end

DataMapper.finalize
DataMapper.auto_upgrade!
 
get '/' do
    erb :index
end
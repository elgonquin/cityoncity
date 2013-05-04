require 'rubygems'
require 'sinatra'
# require 'data_mapper'
# require 'dm-migrations'
# require 'dm-timestamps'

#database connection
#DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
 
get '/' do
    erb :index
end
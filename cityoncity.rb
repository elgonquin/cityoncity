require 'rubygems'
require 'sinatra'
require 'data_mapper'

get '/' do

	@city = "Home"

    erb :index
end

get '/berlin' do

	#database connection
	DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
	
	class CityLink
	    include DataMapper::Resource
	    
	    property :id, Serial
	    property :city, String
	    property :link, String

	    def self.london
	    	all(city: "London").map(&:link)
	    end

	    def self.tokyo
	    	all(city: "Tokyo").map(&:link)
	    end

	    def self.newyork
	    	all(city: "NewYork").map(&:link)
	    end

	    def self.berlin
	    	all(city: "Berlin").map(&:link)
	    end

		def self.melbourne
	    	all(city: "Melbourne").map(&:link)
	    end

	end

	DataMapper.finalize
	DataMapper.auto_upgrade!

	@images = CityLink.berlin

	time = CityLink.all(city: "Time Searched").map(&:link)
	@searchtime = time[0]

	@city = "Berlin"

	erb :images
end

get '/london' do

	#database connection
	DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
	
	class CityLink
	    include DataMapper::Resource
	    
	    property :id, Serial
	    property :city, String
	    property :link, String

	    def self.london
	    	all(city: "London").map(&:link)
	    end

	    def self.tokyo
	    	all(city: "Tokyo").map(&:link)
	    end

	    def self.newyork
	    	all(city: "NewYork").map(&:link)
	    end

	    def self.berlin
	    	all(city: "Berlin").map(&:link)
	    end

		def self.melbourne
	    	all(city: "Melbourne").map(&:link)
	    end

	end

	DataMapper.finalize
	DataMapper.auto_upgrade!

	@images = CityLink.london

	time = CityLink.all(city: "Time Searched").map(&:link)
	@searchtime = time[0]

	@city = "London"

	erb :images
end

get '/tokyo' do

	#database connection
	DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
	
	class CityLink
	    include DataMapper::Resource
	    
	    property :id, Serial
	    property :city, String
	    property :link, String

	    def self.london
	    	all(city: "London").map(&:link)
	    end

	    def self.tokyo
	    	all(city: "Tokyo").map(&:link)
	    end

	    def self.newyork
	    	all(city: "NewYork").map(&:link)
	    end

	    def self.berlin
	    	all(city: "Berlin").map(&:link)
	    end

		def self.melbourne
	    	all(city: "Melbourne").map(&:link)
	    end

	end

	DataMapper.finalize

	DataMapper.auto_upgrade!

	@images = CityLink.tokyo

	time = CityLink.all(city: "Time Searched").map(&:link)
	@searchtime = time[0]

	@city = "Tokyo"

	erb :images
end

get '/melbourne' do

	#database connection
	DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
	
	class CityLink
	    include DataMapper::Resource
	    
	    property :id, Serial
	    property :city, String
	    property :link, String

	    def self.london
	    	all(city: "London").map(&:link)
	    end

	    def self.tokyo
	    	all(city: "Tokyo").map(&:link)
	    end

	    def self.newyork
	    	all(city: "NewYork").map(&:link)
	    end

	    def self.berlin
	    	all(city: "Berlin").map(&:link)
	    end

		def self.melbourne
	    	all(city: "Melbourne").map(&:link)
	    end

	end

	DataMapper.finalize
	DataMapper.auto_upgrade!

	@images = CityLink.melbourne

	time = CityLink.all(city: "Time Searched").map(&:link)
	@searchtime = time[0]

	@city = "Melbourne"

	erb :images
end

get '/newyork' do

	#database connection
	DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")
	
	class CityLink
	    include DataMapper::Resource
	    
	    property :id, Serial
	    property :city, String
	    property :link, String

	    def self.london
	    	all(city: "London").map(&:link)
	    end

	    def self.tokyo
	    	all(city: "Tokyo").map(&:link)
	    end

	    def self.newyork
	    	all(city: "NewYork").map(&:link)
	    end

	    def self.berlin
	    	all(city: "Berlin").map(&:link)
	    end

		def self.melbourne
	    	all(city: "Melbourne").map(&:link)
	    end

	end

	DataMapper.finalize
	DataMapper.auto_upgrade!

	@images = CityLink.newyork

	time = CityLink.all(city: "Time Searched").map(&:link)
	@searchtime = time[0]

	@city = "New York"

	erb :images
end
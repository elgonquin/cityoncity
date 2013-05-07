require 'httparty'
require 'data_mapper'
require 'json'

task :default => ["updatedb"]

desc "Task to update the database with today's Google image result links."
task :updatedb do
	#get google image search results
	london = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=london')
	newyork = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=new%20york')
	tokyo = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=tokyo')
	berlin = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=berlin')
	melbourne = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=melbourne')

	#database connection
	DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

	#create database model
	class CityLink
	    include DataMapper::Resource
	    
	    property :id, Serial
	    property :city, String
	    property :link, String, length: 2000

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
	DataMapper.auto_migrate!

	# create/update database links based on new google results
	london["items"].each do |item|
		l=CityLink.create(city: "London", link: item["link"])
	end

	newyork["items"].each do |item|
		l=CityLink.create(city: "NewYork", link: item["link"])
	end

	tokyo["items"].each do |item|
		l=CityLink.create(city: "Tokyo", link: item["link"])
	end

	berlin["items"].each do |item|
		l=CityLink.create(city: "Berlin", link: item["link"])
	end

	melbourne["items"].each do |item|
		l=CityLink.create(city: "Melbourne", link: item["link"])
	end

	time = Time.now.utc.to_s
	timedb =  CityLink.create(city: "Time Searched", link: time)
	
end

desc "Delete all entries in the database."
task :deletedb do
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

	CityLink.all.destroy

end


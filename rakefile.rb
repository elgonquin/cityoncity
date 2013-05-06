require 'httparty'
require 'data_mapper'
require 'json'

task :default => ["updatedb"]

desc "Set up the database"
task :migratedb do
	#database connection
	DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

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

	# add in test entries (to be deleted from production)
	test1 = CityLink.create(city: "London", link: "http://cdn.londonandpartners.com/visit/london-organisations/houses-of-parliament/63950-640x360-london-icons2-640.jpg")
	test2 = CityLink.create(city: "Tokyo", link: "http://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Skyscrapers_of_Shinjuku_2009_January_(revised).jpg/500px-Skyscrapers_of_Shinjuku_2009_January_(revised).jpg")
	test3 = CityLink.create(city: "Tokyo", link: "http://www3.jjc.edu/ftp/wdc11/msmith/IMAGES/tokyo%20(9).jpg")
	test4 = CityLink.create(city: "Tokyo", link: "http://1.bp.blogspot.com/_bNaCXDNN6YQ/S774k9cJNNI/AAAAAAAAAA8/2CrR7a30cSA/s1600/shinjuku_at_night_tokyo_japan.jpg")
	test5 = CityLink.create(city: "London", link: "http://i.telegraph.co.uk/multimedia/archive/02423/london_2423609b.jpg")
	test6 = CityLink.create(city: "Berlin", link: "http://media-cdn.tripadvisor.com/media/photo-s/00/12/08/be/brandenburg-gate-at-night.jpg")
	test7 = CityLink.create(city: "Melbourne", link: "http://www.starball.com.au/wp-content/uploads/melbourne-tourism-news.jpg")
	test8 = CityLink.create(city: "Berlin", link: "http://www.travelingdiamond.com/wp-content/uploads/2013/01/berlin-city-night-2.jpg")
	test9 = CityLink.create(city: "Melbourne", link: "http://www.sabrehq.com/destnations/melbourne.jpg")

	# test for entries (to be deleted from production)
	puts "--london--"
	puts CityLink.london
	puts "--Tokyo--"
	puts CityLink.tokyo
	puts "--berlin--"
	puts CityLink.berlin
	puts "--melbourne--"
	puts CityLink.melbourne

end

desc "Task to update the database with today's Google image result links."
task :updatedb do
	#get google image search results
	#london = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=london')
	#newyork = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=new%20york')
	#tokyo = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=tokyo')
	#berlin = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=berlin')
	#melbourne = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=melbourne')

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
	DataMapper.auto_upgrade!

	# create/update database links based on new google results
	# london["items"].each do |item, index|
	# 	l+index=CityLink.create(city: "London", link: item["link"])
	# end

	# manual database entries for testing (to be deleted from production)
	test1 = CityLink.update(city: "London", link: "http://cdn.londonandpartners.com/visit/london-organisations/houses-of-parliament/63950-640x360-london-icons2-640.jpg")
	test2 = CityLink.update(city: "Tokyo", link: "http://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Skyscrapers_of_Shinjuku_2009_January_(revised).jpg/500px-Skyscrapers_of_Shinjuku_2009_January_(revised).jpg")
	test3 = CityLink.update(city: "Tokyo", link: "http://www3.jjc.edu/ftp/wdc11/msmith/IMAGES/tokyo%20(9).jpg")
	test4 = CityLink.update(city: "Tokyo", link: "http://1.bp.blogspot.com/_bNaCXDNN6YQ/S774k9cJNNI/AAAAAAAAAA8/2CrR7a30cSA/s1600/shinjuku_at_night_tokyo_japan.jpg")
	test5 = CityLink.update(city: "London", link: "http://i.telegraph.co.uk/multimedia/archive/02423/london_2423609b.jpg")
	test6 = CityLink.update(city: "Berlin", link: "http://media-cdn.tripadvisor.com/media/photo-s/00/12/08/be/brandenburg-gate-at-night.jpg")
	test7 = CityLink.update(city: "Melbourne", link: "http://www.starball.com.au/wp-content/uploads/melbourne-tourism-news.jpg")
	test8 = CityLink.update(city: "Berlin", link: "http://www.travelingdiamond.com/wp-content/uploads/2013/01/berlin-city-night-2.jpg")
	test9 = CityLink.update(city: "Melbourne", link: "http://www.sabrehq.com/destnations/melbourne.jpg")

	# output test results to validate (to be deleted from production)
	tokyo_array = CityLink.tokyo
	london_array = CityLink.melbourne
	puts CityLink.all
	puts "--london links--"
	puts london_array
	puts "--tokyo links--"
	puts tokyo_array
	puts "task run & complete"	
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

	puts "database cleared"

end


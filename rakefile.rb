require 'httparty'
require 'data_mapper'
require 'json'
require 'RMagick'
include Magick
require 'aws-sdk'

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

desc "Task to run the search and composite the images for each City, then save them to AWS"
task :archiveimages do

	#Instantiate a new S3 client
	s3 = AWS::S3.new
	#Set S3 bucket
	bucket = s3.buckets['cityoncity']

	#Create black image object as base for output
	outputimage = Image.new(960,640) {self.background_color="black"}

	#Create variable to store current date as a string
	date = Time.now.strftime("%y%m%d")

	#Create an array of cities to search and archive images for, can be added to.
	cities = ["london",
				"newyork",
				"tokyo",
				"berlin",
				"melbourne"
			]

	#For each city in the cities array, get search results using city name in array. 
	#Then for each search result extract the link, create an temp image object based on the linked image, resize to suit, set opacity to 87.5% transparent. 
	#Composite temp image onto output image object.
	#After all search results composited, save output image object to "today" and "archive folders" on AWS as public files
	#Reset output image for next city search results use.
	cities.each do |city|
		cityinfo = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgtype=photo&imgSize=xlarge&q='+city)
		cityinfo["items"].each do |item|
			itemlink = item["link"].to_s
			image = Image.read(itemlink)
			image[0].resize_to_fill!(960,640)
			image[0].opacity = Magick::MaxRGB * 0.875
			outputimage = image[0].composite(outputimage,CenterGravity,PlusCompositeOp)
		end 
		bucket.objects["today/"+city+".jpg"].write(outputimage.to_blob, {:acl=>:public_read})
		bucket.objects["archive/"+date+city+".jpg"].write(outputimage.to_blob, {:acl=>:public_read})
		outputimage = Image.new(960,960) {self.background_color="black"}
	end

end
require 'httparty'
require 'data_mapper'

task :default => ["updatedb"]

desc "Task to update the database with today's Google image result links."
task :updatedb do
	london = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=london')
	newyork = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=new%20york')
	tokyo = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=tokyo')
	berlin = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=berlin')
	melbourne = HTTParty.get('https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=melbourne')

	
puts "task run & complete"	
end
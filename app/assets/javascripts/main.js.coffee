require ['order!jquery','order!backbone','order!app'], ($, Backbone, App) ->

	log "#{App.name} \nVersion: #{App.version}"
	do App.initialize
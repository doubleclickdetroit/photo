require ['jquery','backbone','app'], ($, Backbone, App) ->

	log "#{App.name} \nVersion: #{App.version}"
	do App.initialize
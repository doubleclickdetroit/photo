require ['jquery','underscore','backbone','main'], ($, _, Backbone, App) ->

	log "#{App.name} \nVersion: #{App.version}"
	do App.initialize
define ['underscore','backbone'], (_, Backbone) ->
	
	AppRouter = Backbone.Router.extend
		
		routes:
			"prospects": "showProspects"
			"*actions"  : "defaultAction"

		showProspects: ->
			console.log "showProspects invoked!"

		defaultAction: (action)->
			console.log "defaultAction invoked!"

	initialize: ->
		new AppRouter

		Backbone.history.start
			pushState: true
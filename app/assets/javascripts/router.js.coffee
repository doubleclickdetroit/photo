define [], (require) ->

	PushState = require 'utils/pushstate'
	Backbone  = require 'backbone'

	AppRouter = Backbone.Router.extend

		routes:
			""                     : "session_actions"
			"users/:action"        : "session_actions"
			"users/:action/:other" : "session_actions" # can we rename "password/new" to "password"?

			"*splat" : "defaultAction"

		session_actions: (action) ->
			Session = require 'views/session'
			do Session.getInstance()["do_#{action or= 'home'}"]

		defaultAction: (splat) ->
			log 'defaultAction invoked!'

	initialize: ->
		new AppRouter # eventually replace with line below
		# PushState.getInstance().subscribe new AppRouter

		Backbone.history.start
			pushState: true
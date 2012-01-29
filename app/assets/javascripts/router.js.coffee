define [], (require) ->

	PushState = require 'utils/pushstate'
	Backbone  = require 'backbone'

	AppRouter = Backbone.Router.extend

		routes:
			""               : "session_actions"
			"users/*actions" : "session_actions"

			"*splat" : "defaultAction"

		session_actions: (actions = "home") ->
			Session = require 'views/session/session_facade'
			do Session.getInstance()["do_#{actions.replace '/', '_'}"]

		defaultAction: (splat) ->
			log 'defaultAction invoked!'

	initialize: ->
		# new AppRouter # eventually replace with line below
		PushState.getInstance().subscribe new AppRouter

		Backbone.history.start
			pushState: true
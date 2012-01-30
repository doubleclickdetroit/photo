define [], (require) ->

	PushState = require 'utils/pushstate'
	Backbone  = require 'backbone'

	reformatPathToActions = (path) ->
		path.replace '/', '_'

	AppRouter = Backbone.Router.extend

		routes:
			""               : "home_actions"
			"users/*actions" : "session_actions"
			"*splat"         : "default_actions"

		home_actions: ->
			log 'home_actions invoked!'

		session_actions: (path) ->
			Session = require 'views/session/session_facade'
			do Session.getInstance()["do_#{reformatPathToActions path}"]

		default_actions: (splat) ->
			log 'default_actions invoked!'

	initialize: ->
		PushState.getInstance().subscribe new AppRouter

		Backbone.history.start
			pushState: true
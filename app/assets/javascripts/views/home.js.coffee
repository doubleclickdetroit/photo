define [], (require) ->
	
	$        = require 'jquery'
	Backbone = require 'backbone'

	HomeView = Backbone.View.extend

		el: $ '#main'

		events:
			'click': 'handleClick'

		initialize: ->
			log 'HomeView init'

		handleClick: (evt) ->
			log 'handleClick'

	HomeView
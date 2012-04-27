define ['./mediator'], (mediator) ->

	facade = facade or {}

	facade.subscribe = (subscriber, channel, callback) ->
		#can compare against permissions
		mediator.subscribe channel, callback
		@

	facade.publish = (channel) ->
		mediator.publish channel
		@

	facade
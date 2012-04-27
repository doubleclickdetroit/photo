define [], (obj) ->

	obj ?= {}
	channels = {}

	obj.subscribe = (name, subscription) ->
		channels[name] = [] if channels[name] is null
		channels[name].push subscription
		@

	obj.publish = (name, args...) ->
		channel.apply(@, args) for channel in channels[name] if channels[name]?
		@

	obj
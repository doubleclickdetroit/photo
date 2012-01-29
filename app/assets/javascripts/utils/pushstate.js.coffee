define [], (require) ->

	$         = require 'jquery'
	Singleton = require './singleton'

	class PushState extends Singleton

		__routers = []

		notifyRouter = (uri, router) ->
			router.navigate uri, true

		handleHyperlinkPushState = (evt) ->
			do evt.preventDefault
			uri = $(this).attr 'href'
			notifyRouter uri, router for router in __routers

		handlePopStateEvent = (evt) ->
			uri = location.pathname.substr 1
			notifyRouter uri, router for router in __routers

		constructor: ->
			$(window).bind 'popstate', handlePopStateEvent
			$(document).delegate 'a', 'click', handleHyperlinkPushState

		initialize: ->
			log 'PushState init'

		subscribe: (router) ->
			__routers.push router

	PushState
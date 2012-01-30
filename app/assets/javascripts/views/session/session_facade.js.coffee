define [], (require) ->

	Singleton   = require 'utils/singleton'
	SessionView = require './session'

	class Facade extends Singleton

		initialize: ->
			@sessionView = new SessionView

		do_sign_in: ->
			do @sessionView.do_sign_in

		do_sign_up: ->
			do @sessionView.do_sign_up

		do_password_new: ->
			do @sessionView.do_password_new

	Facade
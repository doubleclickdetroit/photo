define [], (require) ->

	$        = require 'jquery'
	Backbone = require 'backbone'

	Singleton = require 'utils/singleton'

	tmpl_sign_in  = require 'text!templates/session/sign_in.html'
	tmpl_sign_up  = require 'text!templates/session/sign_up.html'
	tmpl_password = require 'text!templates/session/password_new.html'

	class Session extends Singleton

		initialize: ->
			log 'Session init'
			log 'Templates loaded: [sign_in, sign_up, password_new]'

		do_home: ->
			log 'render: "home"'

		do_sign_in: ->
			log 'render: "sign_in"'
			
		do_sign_up: ->
			log 'render: "sign_up"'

		do_password: ->
			log 'render: "password"'

	Session
define [], (require) ->

	$        = require 'jquery'
	Backbone = require 'backbone'

	tmpl_sign_in  = require 'text!templates/session/sign_in.html'
	tmpl_sign_up  = require 'text!templates/session/sign_up.html'
	tmpl_password = require 'text!templates/session/password_new.html'

	Session = Backbone.View.extend

		el: $ '#main'

		initialize: ->
			log 'Session.Backbone.View initialize'

		do_home: ->
			log 'render: "home"'

		do_sign_in: ->
			log 'render: "sign_in"\n', tmpl_sign_in

		do_sign_up: ->
			log 'render: "sign_up"\n', tmpl_sign_up

		do_password_new: ->
			log 'render: "password_new"\n', tmpl_password

	Session
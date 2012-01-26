define ['jquery','backbone'], ($,Backbone) ->

	prospectFormView = Backbone.View.extend

		el: $ '#new_prospect'

		events:
			"ajax:success" : "handleSuccess"

		initialize: ->
			this.$title   = this.el.siblings "legend"
			this.$wrapper = do this.el.parent

		handleSuccess: (evt, json) ->
			self = this

			do this.el.slideUp

			this.$wrapper.slideUp ->
				self.render json
				do self.$wrapper.slideDown

		render: (json) ->
				this.$title.text json.title
				this.el.replaceWith $ '<p>', text: json.text


	new prospectFormView
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('#new_prospect').live 'ajax:success', (evt, json) ->
	$form    = $ this
	$title   = $form.siblings 'legend'
	$wrapper = do $form.parent

	do $form.slideUp

	$wrapper.slideUp ->
		$title.text json.title
		$form.replaceWith $ '<p>', text: json.text

		do $wrapper.slideDown
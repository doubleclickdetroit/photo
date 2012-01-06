# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('#new_prospect').live 'ajax:success', (evt, json, status) ->
  $('fieldset').slideUp 500, ->
    $(this).empty()
    $(this).append $('<legend>', text: json.title)
    $(this).append $('<p>', text: json.text)
    $(this).slideDown 500

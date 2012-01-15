($ 'form').live 'ajax:error', (evt, xhr) ->

	EXPLANATION = "error_explanation"
	FIELD_WRAP  = "field_with_errors"

	$form   = $ this
	$fields = $form.find ":input:visible:not(:submit)"
	$cont   = if $("##{EXPLANATION}").length then $("##{EXPLANATION}") else $('<div>', id:EXPLANATION).prependTo($form)
	$list   = $("<ul>").appendTo $cont.empty()

	$fields.each ->
		$field = $ this
		$field.unwrap() if $field.parent().is ".#{FIELD_WRAP}"

	data   = JSON.parse xhr.responseText
	errors = for field, error of data
		$list.append $ "<li>", text: "#{field} #{error}"
		($fields.filter "[name*='[#{field}]']").wrapAll("<div class='#{FIELD_WRAP}' />")

	$cont.prepend $ "<h2>", text: "#{errors.length} error#{if errors.length > 1 then "s" else ""} prohibited this prospect from being saved:"

	data
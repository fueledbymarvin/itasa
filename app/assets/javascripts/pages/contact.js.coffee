window.initContact = (color) ->
	$('.college-wrapper').each ->
		$(this).hover(
			-> $(this).parent().find('img, span').addClass("next")
			-> $(this).parent().find('img, span').removeClass("next")
		)
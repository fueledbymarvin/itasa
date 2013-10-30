window.initSponsor = (color) ->
	$('#donate').click ->
		$('#paypal').submit()

	$('#right').hover(
		-> $('#right, #left').addClass "next"
		-> $('#right, #left').removeClass "next"
	)

	$('#shine').waypoint
		handler: ->
			$('.ray').animate { width: "0.6em" },
				duration: 200
				easing: 'easeInOutCirc'
				complete: ->
					$('.ray').delay(200).animate { opacity: 0 }, { duration: 80 }
					$('.ray').delay(100).animate { opacity: 1 }, { duration: 80 }
		offset: '70%'
		triggerOnce: true
		
	$('.college-wrapper').each ->
		$(this).hover(
			-> $(this).parent().find('img, span').addClass("next")
			-> $(this).parent().find('img, span').removeClass("next")
		)
animateQA = (i) ->
	->
		$('.qa:eq(' + i + ')').addClass("next")

addShadow = ->
	->
		$('.qa').css { boxShadow: "0 1px 1px #161920" }

window.initHome = (color) ->
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

	$('.qa:eq(0)').waypoint
		handler: ->
			for i in [0...$('.qa').length]
				setTimeout(animateQA(i), i * 100)	
			setTimeout(addShadow(), 1000)
		offset: '95%'
		triggerOnce: true

	$('.qa:eq(5)').waypoint
		handler: ->
			$('.wrap-top').css borderTop: "0.2em solid white"
			$('.wrap-top').animate { width: "100%", padding: "0 0.4em" },
				duration: 500
				easing: 'easeInOutQuad'
				complete: ->
					$('.wrap-top').css borderRight: "0.2em solid white"
					$('.wrap-top').animate { height: "6em", padding: "0.4em" },
						duration: 200
						easing: 'easeInOutQuad'
			$('.wrap-bottom').css borderBottom: "0.2em solid white"
			$('.wrap-bottom').animate { width: "100%", padding: "0 0.4em", margin: "0.2em -0.6em", left: 0 },
				duration: 500
				easing: 'easeInOutQuad'
				complete: ->
					$('.wrap-bottom').css borderLeft: "0.2em solid white"
					$('.wrap-bottom').animate { height: "6em", padding: "0.4em", margin: "-6.6em -0.6em" },
						duration: 200
						easing: 'easeInOutQuad'
						complete: ->
							$('.qa:eq(5)').hover(
								->
									$('.wrap-top, .wrap-bottom').animate
										padding: 0
										borderWidth: "0.6em"
									,
										duration: 100
										easing: 'easeInOutQuad'
								->
									$('.wrap-top, .wrap-bottom').animate
										padding: "0.4em"
										borderWidth: "0.2em"
									,
										duration: 100
										easing: 'easeInOutQuad'
							)
								
		offset: $(window).height() - $('.qa:eq(5)').height() * 1.2
		triggerOnce: true
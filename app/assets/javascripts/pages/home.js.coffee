animateQA = (i) ->
	->
		$('.qa:eq(' + i + ')').addClass("next")

window.initHome = ->
	for i in [0...$('.qa').length]
		setTimeout(animateQA(i), i * 100)	

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
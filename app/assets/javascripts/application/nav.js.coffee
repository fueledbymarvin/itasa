jQuery ->
	#$('nav').pjax 'a', '#container'

	pages = ["/", "/about", "/register", "/schedule", "/contact"]
	
	bgColors = buttonColors = ["#00A0B0", "#6A4A3C", "#CC333F", "#EB6841", "#EDC951"]
	defaultColor = "#E1E6E7"

	links = $("nav li a")
	hover = $(".hoverBar")

	overButton = (pos) ->
		->
			$(this).css color: buttonColors[pos]
			$('.hoverBar:eq(' + pos + ')').css height: "5px"

	outButton = (pos) ->
		->
			$(this).css color: defaultColor
			$('.hoverBar:eq(' + pos + ')').css height: "0px"

	changeBg = (pos) ->
		->
			for i in [0...links.length]
				if i isnt pos
					$(hover[i]).css height: "0px"
					$(links[i]).css(color: defaultColor)
						.on('mouseover', overButton(i))
						.on('mouseout', outButton(i))
				else
					$(hover[i]).css height: "5px"
					$(links[i]).css(color: buttonColors[pos])
						.off('mouseover')
						.off('mouseout')
			$('#m-overlay').trigger 'click'

	placeHex = ->
		$('#hex-container').css { top: ( $("#top").height() - $('#hex-container').height() / 2 ) + "px" }

	changing = false

	initLinks = ->
		for i in [0...links.length]
			$(links[i]).click (e) ->
				e.preventDefault()
				if not changing
					changing = true
					target = $(this).attr 'href'
					$('html, body').animate { scrollTop: 0 }, 600, 'easeInOutQuad'
					if target isnt window.location.pathname
						hTop = $('#top').height()
						hBottom = $('#top').height()
						$('#top').animate { height: 0, top: hTop + "px" }, 800, 'easeInOutQuad'
						$('#bottom').animate { height: 0, top: hTop + "px" }, 800, 'easeInOutQuad', ->
							$('#container').css { display: "none" }
							$('#top').css { height: hTop + "px", top: 0 }
							$('#bottom').css { height: hBottom + "px", top: 0 }
							$.pjax { url: target, container: '#container' }

	initNav = ->
		for i in [0...links.length]
			$(hover[i]).css "background-color": buttonColors[i]
			$(links[i]).mouseover(overButton(i))
			$(links[i]).mouseout(outButton(i))
			$(links[i]).click(changeBg(i))
		initLinks()
			

	initNav()

	do changeBg pages.indexOf(window.location.pathname)

	$(document).on 'pjax:success', ->
		$('#top img').load ->
			$('#container').css { display: "block" }
			hTop = $('#top').height()
			hBottom = $('#bottom').height()
			$('#top').css { height: 0, top: hTop + "px" }
			$('#top img').css { height: 0 }
			$('#bottom').css { height: 0, top: hTop + "px" }
			$('#hex').addClass('flipped')
			$('#top img').delay(1000).animate { height: hTop + "px" }
			$('#top').delay(1000).animate { height: hTop + "px", top: 0 }, 1000, 'easeInOutQuad'
			$('#bottom').delay(1000).animate { height: hBottom + "px", top: 0 }, 1000, 'easeInOutQuad', ->
				changing = false

	$(document).on 'pjax:end', ->
		#FIXXXXXXXXXXXXXXXXX to make back work
		do changeBg pages.indexOf(window.location.pathname)

	#mobile
	$('#mobile p').click ->
		$('nav').animate { right: "-10%" }, { duration: 700, easing: "easeInOutBack" }
		$('#m-overlay').css display: "block"
		$('#m-overlay').click ->
			$('nav').animate { right: "-42%" }, { duration: 700, easing: "easeInOutBack" }
			$(this).css display: "none"
			$(this).off 'click'

	$('#top img').load ->
		placeHex()

	$(window).resize ->
		placeHex()
		if $(window).width() > 400
			$('nav').css { right: "0" }
			$('#m-overlay').off 'click'
			$('#m-overlay').css display: "none"
		else
			$('nav').css { right: "-42%" }
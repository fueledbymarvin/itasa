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
		$('#subtitle').css { top: ( $("#top").height() - $('#subtitle').height() / 3 * 2 ) + "px" }

	initNav = ->
		for i in [0...links.length]
			$(hover[i]).css "background-color": buttonColors[i]
			$(links[i]).mouseover(overButton(i))
			$(links[i]).mouseout(outButton(i))
			$(links[i]).click(changeBg(i))
			$(links[i]).click (e) ->
				e.preventDefault()
				target = $(this).attr 'href'
				$('html, body').animate { scrollTop: 0 }, 600, 'easeInOutQuad'
				if target isnt window.location.pathname
					h = $('#top').height()
					$('#top').animate { height: 0, top: h + "px" }, 1000, 'easeInOutQuad'
					$('#bottom').animate { height: 0, top: h + "px" }, 1000, 'easeInOutQuad', ->
						$('#container').css { display: "none" }
						$.pjax { url: target, container: '#container' }

	initNav()

	do changeBg pages.indexOf(window.location.pathname)

	$(document).on 'pjax:success', ->
		$('#top img').load ->
			$('#container').css { display: "block" }
			hTop = $('#top').height()
			hBottom = $('#bottom').height()
			$('#top').css { height: 0, top: hTop + "px" }
			$('#bottom').css { height: 0, top: hTop + "px" }
			$('#top').animate { height: hTop + "px", top: 0 }, 1000, 'easeInOutQuad'
			$('#bottom').animate { height: hBottom + "px", top: 0 }, 1000, 'easeInOutQuad'

	$(document).on 'pjax:end', ->
		#FIXXXXXXXXXXXXXXXXX to make back work
		$('#top').css { top: 0 }
		$('#bottom').css { top: 0 }
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
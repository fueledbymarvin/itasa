jQuery ->

	pages = ["/", "/about", "/register", "/schedule", "/contact"]
	
	navColors = ["#1693A7", "#FC354C", "#E6781E", "#C8CF02", "#F8FCC1"]
	defaultColor = "#E1E6E7"

	links = $('nav li a')
	hover = $('.hoverBar')

	getPage = ->
		pages.indexOf(window.location.pathname)

	overButton = (pos) ->
		->
			$(this).css color: navColors[pos]
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
					$(links[i]).css(color: navColors[pos])
						.off('mouseover')
						.off('mouseout')
			$('#m-overlay').trigger 'click'

	placeHex = ->
		$('#hex-container').css { top: ( $("#top").height() - $('#hex-container').height() / 2 ) + "px" }

	colorHex = (side, pos) ->
		$("#hex-#{side} .hex-top").css { borderBottomColor: navColors[pos] }
		$("#hex-#{side} .hex-middle").css { backgroundColor: navColors[pos] }
		$("#hex-#{side} .hex-bottom").css { borderTopColor: navColors[pos]  }

	colorHex("front", getPage())

	flipHex = (pos) ->
		if $("#hex").hasClass("flipped")
			colorHex("front", pos)
			$("#hex").removeClass("flipped")
		else
			colorHex("back", pos)
			$("#hex").addClass("flipped")

	changing = false
	flipped = false

	initLinks = ->
		for i in [0...links.length]
			$(links[i]).click (e) ->
				e.preventDefault()
				if not changing
					changing = true
					target = $(this).attr 'href'
					$('html, body').animate { scrollTop: 0 }, 300, 'easeInOutQuad'
					if target isnt window.location.pathname
						hTop = $('#top').height()
						hBottom = $('#top').height()
						$('#top').animate { height: 0, top: hTop + "px" }, 600, 'easeInOutQuad'
						$('#bottom').animate { height: 0, top: hTop + "px" }, 600, 'easeInOutQuad', ->
							$('#container').css { display: "none" }
							$('#top').css { height: "auto", top: 0 }
							$('#bottom').css { height: "auto", top: 0 }
							$.pjax { url: target, container: '#container' }

	initNav = ->
		for i in [0...links.length]
			$(hover[i]).css "background-color": navColors[i]
			$(links[i]).mouseover(overButton(i))
			$(links[i]).mouseout(outButton(i))
			$(links[i]).click(changeBg(i))
		initLinks()

	initNav()

	loadIn = ->
		$('#container').css { display: "block" }
		hTop = $('#top').height()
		hBottom = $('#bottom').height()
		$('#top').css { height: 0, top: hTop + "px" }
		$('#top img').css { height: 0 }
		$('#bottom').css { height: 0, top: hTop + "px" }
		flipHex(getPage());
		$('#top img').delay(500).animate { height: hTop + "px" }
		$('#top').delay(500).animate { height: hTop + "px", top: 0 }, 600, 'easeInOutQuad'
		$('#bottom').delay(500).animate { height: hBottom + "px", top: 0 }, 600, 'easeInOutQuad', ->
			$('#top').css { height: "auto" }
			$('#top img').css { height: "auto" }
			$('#bottom').css { height: "auto" }
			changing = false

	do changeBg getPage()

	$(document).on 'pjax:end', ->
		console.log("end")
		do changeBg getPage()
		if $('#top').height() is 0
			$('#top img').load ->
				loadIn()
		else
			loadIn()
			

	# $(document).on 'pjax:end', ->
	# 	if flipped
	# 		flipped = false
	# 	else
	# 		flipHex(getPage())

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
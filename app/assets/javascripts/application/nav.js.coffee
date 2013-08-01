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
		$('#hex-line').css { top: $("#top").height() + "px" }
		$('#hex-container').css { top: ( $("#top").height() + $("#hex-line").height() / 2 - $('#hex-container').height() / 2 ) + "px" }
		$('#hex-bg').css { top: ( $("#top").height() + $("#hex-line").height() / 2 - $('#hex-bg').height() / 2 ) + "px" }

	$('#top img').load ->
		placeHex()

	$(window).resize ->
		placeHex()

	recolor = (hex, lum) ->
		hex = String(hex).replace(/[^0-9a-f]/gi, '')
		if hex.length < 6
			hex = hex[0]+hex[0]+hex[1]+hex[1]+hex[2]+hex[2]
		lum = lum || 0
		rgb = "#"
		for i in [0...3]
			c = parseInt(hex.substr(i*2,2), 16)
			c = Math.round(Math.min(Math.max(0, c + (c * lum)), 255)).toString(16)
			rgb += ("00"+c).substr(c.length)
		rgb

	colorHex = (side, color) ->
		$("#hex-#{side} .hex-top").css { borderBottomColor: color }
		$("#hex-#{side} .hex-middle").css { backgroundColor: color }
		$("#hex-#{side} .hex-bottom").css { borderTopColor: color  }

	darkerFactor = -0.07
	colorHex("front", navColors[getPage()])
	colorHex("bg", recolor(navColors[getPage()], darkerFactor))
	$('#hex-line').css { backgroundColor: recolor(navColors[getPage()], darkerFactor) }

	flipHex = (pos) ->
		if $("#hex").hasClass("flipped")
			colorHex("front", navColors[getPage()])
			$("#hex").removeClass("flipped")
		else
			colorHex("back", navColors[getPage()])
			$("#hex").addClass("flipped")
		colorHex("bg", recolor(navColors[getPage()], darkerFactor))
		$('#hex-line').css { backgroundColor: recolor(navColors[getPage()], darkerFactor) }

	changing = false
	flipped = false

	initLinks = ->
		for i in [0...links.length]
			$(links[i]).click (e) ->
				e.preventDefault()
				# if not changing
				# 	changing = true
				target = $(this).attr 'href'
				# 	$('html, body').animate { scrollTop: 0 }, 300, 'easeInOutQuad'
				# 	if target isnt window.location.pathname
				# 		hTop = $('#top').height()
				# 		hBottom = $('#top').height()
				# 		$('#top').animate { height: 0, top: hTop + "px" }, 600, 'easeInOutQuad'
				# 		$('#bottom').animate { height: 0, top: hTop + "px" }, 600, 'easeInOutQuad', ->
				# 			$('#container').css { display: "none" }
				# 			$('#top').css { height: "auto", top: 0 }
				# 			$('#bottom').css { height: "auto", top: 0 }
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
		$('#bottom').delay(500).animate { height: hBottom + "px", top: $("#hex-line").height() + "px" }, 600, 'easeInOutQuad', ->
			$('#top').css { height: "auto" }
			$('#top img').css { height: "auto" }
			$('#bottom').css { height: "auto" }
			changing = false

	do changeBg getPage()

	$(document).on 'pjax:end', ->
		do changeBg getPage()
		# if $('#top').height() is 0
		# 	$('#top img').load ->
		# 		loadIn()
		# else
		loadIn()

	#mobile
	$('#mobile p').click ->
		$('nav').animate { right: "-2em" }, { duration: 700, easing: "easeInOutBack" }
		$('#m-overlay').css display: "block"
		$('#m-overlay').click ->
			$('nav').animate { right: "-11.5em" }, { duration: 700, easing: "easeInOutBack" }
			$(this).css display: "none"
			$(this).off 'click'
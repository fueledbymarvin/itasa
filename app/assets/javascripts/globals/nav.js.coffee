jQuery ->

	### VARIABLES ###
	pages = ["/", "/about", "/register", "/schedule", "/contact"]
	navColors = ["#4ddfff", "#f8d337", "#00aeef", "#ffff66", "#99c3ff"]
	defaultColor = "#ffffff"
	bgColor = "#2b303e"
	links = $('nav li a')
	allPjax = $('a[data-pjax="true"]')
	hover = $('.hoverBar')
	blockFronts = $('.block-front')
	blockBacks = $('.block-back')
	blocks = $('.block')
	footerWrappers = $('.footer-block-wrapper')
	footerBlocks = $('.footer-block')
	changing = false
	flipped = false
	darkerFactor = -0.07

	### FUNCTIONS ###
	getPage = ->
		pages.indexOf(window.location.pathname)

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
						.hover(overButton(i), outButton(i))
				else
					$(hover[i]).css height: "5px"
					$(links[i]).css(color: navColors[pos])
						.off('mouseenter mouseleave')
			$('#m-overlay').trigger 'click'

	randomize = (a) ->
		for i in [0...a.length]
			tempPos = Math.floor(Math.random() * a.length)
			swapPos = Math.floor(Math.random() * a.length)
			temp = a[tempPos]
			a[tempPos] = a[swapPos]
			a[swapPos] = temp

	colorBlock = (i, color) ->
		->
			$(blockFronts[i]).css backgroundColor: color
			$(blockBacks[i]).css backgroundColor: color
	colorBlocks = (pos, first = false) ->
		->
			if !first
				$('.block-front').addClass("block-transition")
				$('.block-back').addClass("block-transition")
				$('#mobile').addClass("block-transition")
			$('#mobile').css backgroundColor: navColors[pos]
			newColors = []
			for i in [0...blockFronts.length]
				newColors.push recolor(navColors[pos], -0.1 + i * 0.05)
			randomize(newColors)
			for i in [0...blockFronts.length]
				delay = 0
				if !first
					switch i
						when 0 then delay = 200
						when 1, 3 then delay = 100
				setTimeout(colorBlock(i, newColors[i]), delay)

	placeHex = ->
		imgH = $(window).height() / 2.61
		imgW = $(window).width()
		$("#main #top").css { height: imgH + "px" }
		if imgH > imgW / 16 * 9
			$("#main #top img").css
				height: imgH + "px"
				width: "auto"
			$("#main #top img").css
				left: -1 * ($("#main #top img").width() - imgW) / 2 + "px";
				top: 0
		else
			$("#main #top img").css
				width: imgW + "px"
				height: "auto"
			$("#main #top img").css
				top: -1 * ($("#main #top img").height() - imgH) / 2 + "px";
				left: 0
		$('#hex-container').css { top: ( $("#top").height() + $("#hex-line").height() / 2 - $('#hex-container').height() / 2 ) + "px" }
		minHeight =  $(window).height() - ( $("#top").height() + $("#hex-line").height() ) 
		if $('#content').outerHeight() - $('#placeholder').height() < minHeight
			placeholderHeight = minHeight - ( $('#content').outerHeight() - $('#placeholder').height() )
			$('#placeholder').css { height: placeholderHeight }
		else
			$('#placeholder').css { height: 0 }

	colorHex = (side, color, section = "") ->
		$("#{section} #hex-#{side} .hex-top").css { borderBottomColor: color }
		$("#{section} #hex-#{side} .hex-middle").css { backgroundColor: color }
		$("#{section} #hex-#{side} .hex-bottom").css { borderTopColor: color  }
		$('#main .textbox .title p').css color: color
		$('#main .textbox .underline').css borderColor: color

	colorMiddle = (pos) ->
		colorHex("bg", recolor(navColors[pos], darkerFactor), "#main")
		$('#main #hex-line').css { backgroundColor: recolor(navColors[pos], darkerFactor) }

	flipHex = (pos) ->
		if $("#hex").hasClass("flipped")
			colorHex("front", navColors[pos])
			$("#hex").removeClass("flipped")
		else
			colorHex("back", navColors[pos])
			$("#hex").addClass("flipped")

	openNav = ->
		if !changing
			$('#mobile p').fadeOut 300, ->
				$(this).text('X')
				$(this).fadeIn 300
			$('#mobile').off 'click'
			$('#mobile').click ->
				closeNav()
			$('#mobile').animate { right: "9em" }, { duration: 700, easing: "easeInOutBack" }
			$('nav').animate { right: "-2em" }, { duration: 700, easing: "easeInOutBack" }
			$('#m-overlay').css display: "block"
			$('#m-overlay').click ->
				closeNav()

	closeNav = ->
		$('#mobile p').fadeOut 300, ->
			$(this).text('i')
			$(this).fadeIn 300
		$('#mobile').animate { right: 0 }, { duration: 700, easing: "easeInOutBack" }
		$('nav').animate { right: "-11.5em" }, { duration: 700, easing: "easeInOutBack" }
		$('#m-overlay').css display: "none"
		$('#m-overlay').off 'click'
		$('#mobile').off 'click'
		$('#mobile').click ->
			openNav()

	keys = [32..40]

	preventDefault = (e) ->
		e = e or window.event
		if (e.preventDefault)
	    	e.preventDefault()
	  e.returnValue = false

	keydown = (e) ->
	    for i in keys
	        if e.keyCode is keys[i]
	            preventDefault(e)

	wheel = (e) ->
	  	preventDefault(e)

	disable_scroll = ->
		if window.addEventListener
			window.addEventListener('DOMMouseScroll', wheel, false)
		window.onmousewheel = document.onmousewheel = wheel
		document.onkeydown = keydown

	enable_scroll = ->
	    if window.removeEventListener
	    	window.removeEventListener('DOMMouseScroll', wheel, false)
	    window.onmousewheel = document.onmousewheel = document.onkeydown = null

	initLinks = ->
		for i in [0...allPjax.length]
			$(allPjax[i]).click (e) ->
				e.preventDefault()
				target = $(this).attr 'href'
				if target isnt window.location.pathname
					if not changing
						changing = true
					$('body').animate { scrollTop: 0 }, 300, 'easeInOutQuad', ->
						disable_scroll()
						$('#desaturate').css { opacity: 1, zIndex: 198 }
						placeHex()
						$('#main.container').attr("id", "prev")
						main = $('<div id="main" class="container"></div>')
						main.css
							position: "absolute"
							width: $(window).width() + "px"
						main.appendTo('#wrapper')
						$.pjax { url: target, container: '#main' }

	initNav = ->
		$('#mobile').hover(
			->
				$('#mobile p').addClass('spin')
				if $('#mobile p').text() is 'i'
					openNav()
			->
				$('#mobile p').removeClass('spin')
		)
		for i in [0...links.length]
			$(hover[i]).css "background-color": navColors[i]
			$(links[i]).hover(overButton(i), outButton(i)).click(changeBg(i))
		initLinks()

	loadIn = (pos) ->
		$("#main").wrap('<div id="circle" />')
		$("#circle").css
			top: $("#hex-container").offset()["top"] + $("#hex-container").height() / 2 - $("#circle").outerHeight() / 2 + "px"
			left: $("#hex-container").offset()["left"] + $("#hex-container").width() / 2 - $("#circle").outerWidth() / 2 + "px"
		$("#main").css
			top: -1 * ($("#circle").offset()["top"] + 2000) + "px"
			left: -1 * ($("#circle").offset()["left"] + 2000) + "px"
		finalRadius = Math.ceil(Math.sqrt(Math.pow($(window).width(), 2) + Math.pow($(window).height(), 2)))
		options =
			duration: 600
			easing: 'easeInOutQuad'
			step: ->
				$("#circle").css
					top: $("#hex-container").offset()["top"] + $("#hex-container").height() / 2 - $("#circle").outerHeight() / 2 + "px"
					left: $("#hex-container").offset()["left"] + $("#hex-container").width() / 2 - $("#circle").outerWidth() / 2 + "px"
				$("#main").css
					top: -1 * ($("#circle").offset()["top"] + 2000) + "px"
					left: -1 * ($("#circle").offset()["left"] + 2000) + "px"
			complete: ->
				$('#desaturate').css { opacity: 0, zIndex: 0 }
				enable_scroll()
				$("#prev").remove()
				$("#main").unwrap()
				$("#main").css
					width: "100%"
					top: 0
					left: 0
					position: "static"
				placeHex()
				changing = false
				initPage(getPage())
		$("#top img").load ->
			do changeBg pos
			colorMiddle(pos)
			flipHex(pos)
			placeHex()
			setTimeout(colorBlocks(pos), 600)
			$("#circle").delay(500).animate { width: finalRadius + "px", height: finalRadius + "px" }, options

	flipBlock = (i) ->
		->
			$(blocks[i]).addClass 'flipped'
	flipBlockBack = (i) ->
		->
			$(blocks[i]).removeClass 'flipped'

	footerUp = (i) ->
		->
			$(footerBlocks[i]).stop(true).animate { top: "-3.2em" }, { duration: 400, easing: 'easeInOutBack' }
			$("footer p").text $(footerBlocks[i]).data("subtitle")
			$("footer p").css color: "white"

	footerDown = (i) ->
		->
			$(footerBlocks[i]).stop(true).animate { top: 0 }, { duration: 400, easing: 'easeInOutBack' }
			$("footer p").text 'fueled by marvin'
			$("footer p").css color: "#8892ad"

	initPage = (pos) ->
		switch pos
			when 0 then window.initHome(navColors[pos])
			when 1 then window.initAbout(navColors[pos])
			when 2 then window.initRegister(navColors[pos])
			when 3 then window.initSchedule(navColors[pos])
			when 4 then window.initContact(navColors[pos])
		$('.textbox').each ->
			$(this).find('.title').waypoint
				handler: ->
					$(this).find('.line').animate { width: '100%' },
						duration: 500
						easing: 'easeInOutQuad'
				offset: '80%'
				triggerOnce: true
			$(this).find('.underline').each ->
				$(this).waypoint
					handler: ->
						$(this).animate { width: '1em' }, { duration: 500, easing: 'easeOutBack' }
					offset: '80%'
					triggerOnce: true


	httpInit = (pos) ->
		->
			if window.finished
				clearInterval(checkFinished)
				initPage(pos)

	### INITIALIZE ###
	$('#top img').load ->
		placeHex()

	$(window).resize ->
		placeHex()

	initNav()
	
	initialPage = getPage()
	checkFinished = setInterval(httpInit(initialPage), 100)
	do changeBg initialPage
	do colorBlocks initialPage, true
	colorHex("front", navColors[initialPage])
	colorMiddle(initialPage)

	$(document).on 'pjax:end', ->
		pos = getPage()
		if changing
			loadIn(pos)
		else
			$("#wrapper").load window.location.pathname + " #main", ->
				do changeBg pos
				flipHex(pos)
				do colorBlocks(pos)
				colorMiddle(pos)
				$("#top img").load ->
					placeHex()
					initPage(pos)

	$('#title').hover(
		->
			for i in [0...blocks.length]
				setTimeout flipBlock(i), 30 * i
		->
			for i in [0...blocks.length]
				setTimeout flipBlockBack(i), 30 * i
	)

	for i in [0...footerWrappers.length]
		$(footerWrappers[i]).hover(footerUp(i), footerDown(i))
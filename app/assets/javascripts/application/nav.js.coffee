jQuery ->
	$('nav').pjax 'a', '#container'

	pages = ["/", "/about", "/register", "/schedule", "/contact"]
	
	bgColors = buttonColors = ["#00A0B0", "#6A4A3C", "#CC333F", "#EB6841", "#EDC951"]
	defaultColor = "#231f20"

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
			$('#bg').css "background-color": bgColors[pos]
			$('#m-overlay').trigger 'click'

	for i in [0...links.length]
		$(hover[i]).css "background-color": buttonColors[i]
		$(links[i]).click(changeBg(i))
			.mouseover(overButton(i))
			.mouseout(outButton(i))

	$(links[0]).trigger 'click'

	$(document).on 'pjax:start', ->
		do changeBg pages.indexOf(window.location.pathname)

	#mobile
	$('#mobile p').click ->
		$('nav').animate { right: "-10%" }, { duration: 700, easing: "easeInOutBack" }
		$('#m-overlay').css display: "block"
		$('#m-overlay').click ->
			$('nav').animate { right: "-42%" }, { duration: 700, easing: "easeInOutBack" }
			$(this).css display: "none"
			$(this).off 'click'

	$(window).resize ->
		if $(window).width() > 400
			$('nav').css { right: "0" }
			$('#m-overlay').off 'click'
			$('#m-overlay').css display: "none"
		else
			$('nav').css { right: "-42%" }
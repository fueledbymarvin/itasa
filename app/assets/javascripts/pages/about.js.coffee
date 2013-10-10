bioIn = (dept, pos) ->
	bio = $('.dept[data-dept=' + dept + ']').find('.bio-wrapper[data-pos=' + pos + ']')
	$(bio).css({visibility: "hidden", height: "auto"})
	original = $(bio).height()
	$(bio).css {visibility: "visible", height: 0}
	$(bio).delay(100).animate { height: original + "px" },
		duration: 300
		easing: 'easeInOutQuad'
		complete: ->
			$('html, body').animate { scrollTop: $('.subtitle[data-dept=' + dept + ']').offset().top - 15 }

window.initAbout = (color) ->
	$('.triangle').css {display: "none"}
	$('.text .dept').each ->
		$(this).waypoint
			handler: ->
				for separator, i in $(this).find('.separator')
					$(separator).delay(i * 150).animate { height: '2em' }, { duration: 600, easing: 'easeOutBack' }
			offset: '80%'
			triggerOnce: true

	$('.dept img').each ->
		$(this).click ->
			$(this).css { borderColor: color }
			pos = $(this).data("pos")
			dept = $(this).parent().data("dept")
			open = null
			$('.dept .bio-wrapper').each ->
				if $(this).height() isnt 0
					open = this
			if open
				openPos = $(open).data("pos")
				openDept = $(open).parent().data("dept")
				$(this).parent().parent().parent().find('.dept[data-dept=' + openDept + ']').find('img[data-pos=' + openPos + ']').css { borderColor: "white" }
				$(open).animate { height: 0 },
					duration: 300
					easing: 'easeInOutQuad'
					complete: ->
						if(!(openPos == pos && openDept == dept))
							bioIn(dept, pos)
			else
				bioIn($(this).parent().data("dept"), pos)

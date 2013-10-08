window.initAbout = ->
	$('.text .dept').each ->
		$(this).waypoint
			handler: ->
				for separator, i in $(this).find('.separator')
					$(separator).delay(i * 150).animate { height: '2em' }, { duration: 600, easing: 'easeOutBack' }
			offset: '80%'
			triggerOnce: true
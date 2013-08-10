

animateQA = (i) ->
	->
		$('.qa:eq(' + i + ')').addClass("next")

window.initHome = ->
	for i in [0...$('.qa').length]
		setTimeout(animateQA(i), i * 100)
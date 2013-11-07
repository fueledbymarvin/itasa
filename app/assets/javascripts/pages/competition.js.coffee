window.initCompetition = (color) ->
	$("#gform").css { height: $(window).height() - $("#gform").offset().top + "px" }
	$(window).resize ->
		$("#gform").css { height: $(window).height() - $("#gform").offset().top + "px" }
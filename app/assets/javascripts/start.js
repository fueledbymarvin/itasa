$(document).ready(function () {

	$("body").css({
		overflow: "hidden"
	});
	$("body").queryLoader2({onComplete: function() {
		$("<div id='circleWindow'><div id='circleReveal'></div></div>").appendTo($("body"));
		$("#logo").css({marginTop: "-" + $("#logo").height() / 2 + "px"});
		$("nav").css({marginTop: "-"  + $("nav").height() + "px"});
		$("#circleWindow").css({
			position: "absolute",
			width: "100%",
			height: "100%",
			overflow: "hidden",
			zIndex: "666999"
		});
		$("#circleReveal").css({
			width: "0px",
			height: "0px",
			overflow: "hidden",
			position: "absolute",
			border: "2000px solid white",
			"border-radius": "10000px"
		});
		$("#circleReveal").css({
			top: $(window).height() / 2 - $("#circleReveal").outerHeight() / 2 + "px",
			left: $(window).width() / 2 - $("#circleReveal").outerWidth() / 2 + "px"
		});
		var finalRadius = Math.ceil(Math.sqrt(Math.pow($(window).width(), 2) + Math.pow($(window).height(), 2)));
		$("nav").delay(700).animate({marginTop: 0}, 500);
		$("#circleReveal").delay(200).animate({
			width: finalRadius + "px",
			height: finalRadius + "px"
		}, {
			duration: 800,
			step: function() {
				$("#circleReveal").css({
					top: $(window).height() / 2 - $("#circleReveal").outerHeight() / 2 + "px",
					left: $(window).width() / 2 - $("#circleReveal").outerWidth() / 2 + "px"
				});
			},
			complete: function() {
				$("#circleWindow").remove();
				$(window).resize(function() {
					$("#logo").css({marginTop: "-" + $("#logo").height() / 2 + "px"});
				});
				$("body").css({
					overflow: "visible"
				});
			}
		});
	}});
});
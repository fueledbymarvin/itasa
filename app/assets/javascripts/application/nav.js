$(document).ready(function() {
	$('nav').pjax('a', '#container');

	var pages = ["/", "/about", "/register", "/schedule", "/contact"];
	$(document).on('pjax:start', function() {
		changeBg(pages.indexOf(window.location.pathname))();
	});

	$("#mobile p").click(function() {
		$("nav").css("display", "block");
	});

	function changeBg(pos) {
		return function() {
			for(var i = 0; i < $("nav li a").length; i++) {
				if(i != pos) {
					$(".hoverBar:eq(" + i + ")").css({height: "0px"});
					$("nav li a:eq(" + i + ")").css({color: "#231f20"}).on('mouseover', overButton(i)).on('mouseout', outButton(i));
				}
				else {
					$(".hoverBar:eq(" + i + ")").css({height: "5px"});
					$("nav li a:eq(" + i + ")").css({color: buttonColors[pos]}).off('mouseover').off('mouseout');
				}
			}
			$("#bg").css({"background-color": bgColors[pos]});
		}
	}
	function overButton(pos) {
		return function() {
			$(this).css({"color": buttonColors[pos]});
			$(".hoverBar:eq(" + pos + ")").css({height: "5px"});
		}
	}
	function outButton(pos) {
		return function() {
			$(this).css({"color": "#231f20"});
			$(".hoverBar:eq(" + pos + ")").css({height: "0px"});
		}
	}
	var bgColors;
	var buttonColors;
	bgColors = buttonColors = ["#00A0B0", "#6A4A3C", "#CC333F", "#EB6841", "#EDC951"];
	//var bgColors = ["#33ddff", "#33ff77", "#8066ff", "#ff4c6a", "#ffff33"];
	//var buttonColors = ["#4cc3ff", "#45e57a", "#8066ff", "#ff4c6a", "#e5e52e"];
	for(var i = 0; i < $("nav li a").length; i++) {
		$(".hoverBar:eq("+ i + ")").css({"background-color": buttonColors[i]});
		$("nav li a:eq(" + i + ")").click(changeBg(i)).mouseover(overButton(i)).mouseout(outButton(i));
	}
});
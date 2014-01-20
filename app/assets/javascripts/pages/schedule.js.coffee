window.initSchedule = (color) ->
	$('.text-btn.more').click ->
    $(this).parent().find('.speaker-bio').css
      display: "block"
    $(this).css
      display: "none"

  $('.text-btn.close').click ->
    $(this).parent().parent().find('.speaker-bio').css
      display: "none"
    $(this).parent().parent().find('.text-btn.more').css
      display: "block"
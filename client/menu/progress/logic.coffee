$(document).scroll (e) ->
  scrollPercent = $(window).scrollTop() / ($(document).height() - $(window).height()) * 100
  $('#progress').css 'width', Math.round(scrollPercent) + '%'

$ ->
  spinnerOpts =
    lines: 15
    length: 15
    radius: 20
    width: 7

  $('#photoCarousel').spin spinnerOpts, '#333'
  $('#photoCarousel').imagesLoaded ($images) ->
    $(@).spin false
    $images.fadeIn()
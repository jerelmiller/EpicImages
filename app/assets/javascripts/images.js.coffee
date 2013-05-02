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

  $('.photo').spin()
  $('.photo').imagesLoaded ($image) ->
    $(@).spin false
    $image.fadeIn()

  unless $('.photos').is(':empty')
    $('.photos').masonry
      itemSelector: '.photo'
$ ->
  $(window).load ->
    $('.photo').width $(window).width() / 5 - 15
    $('.pinterest').masonry
      itemSelector: '.photo'

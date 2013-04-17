class EpicImages.Views.Gallery extends Backbone.View
  template: JST['backbone/templates/galleries/gallery']

  attributes:
    class: 'galleryItem'

  events:
    'mouseover' : 'onMouseover'
    'mouseleave'  : 'onMouseleave'

  render: =>
    @$el.html @template @model.toJSON()
    @_hideCaption()
    @

  onMouseover: =>
    @$('img').animate opacity: 0.7, 200
    @$('.caption').show().animate top: '-65px', 200, 'easeInOutExpo'

  onMouseleave: =>
    @$('img').animate opacity: 1, 200
    @$('.caption').show().animate top: '0px', 200, 'easeOutQuint', @_hideCaption

  _hideCaption: =>
    @$('.caption').hide()
class EpicImages.Views.TagGallery extends Backbone.View
  template: JST['backbone/templates/tags/tag_gallery']

  attributes:
    class: 'galleryItem'

  events:
    'mouseover' : 'onMouseover'
    'mouseleave'  : 'onMouseleave'

  render: =>
    @$el.html @template @model.toJSON()
    @_hideCaption()
    @_waitForImageLoad()
    @

  onMouseover: =>
    @$('img').animate opacity: 0.7, 200
    @$('.caption').show().animate top: '-65px', 200, 'easeInOutExpo'

  onMouseleave: =>
    @$('img').animate opacity: 1, 200
    @$('.caption').show().animate top: '0px', 200, 'easeOutQuint', @_hideCaption

  _hideCaption: =>
    @$('.caption').hide()

  _waitForImageLoad: =>
    @_startSpinner()
    @undelegateEvents()
    @$('img').imagesLoaded ($image) =>
      @$el.spin false
      $image.fadeIn()
      @delegateEvents()

  _startSpinner: =>
    @$el.spin @_spinnerOpts, '#333'
    @$('.spinner').css 'top', '100px'
    @$('.spinner').css 'left', '145px'

  _spinnerOpts: =>
    _.extend {},
      lines: 13
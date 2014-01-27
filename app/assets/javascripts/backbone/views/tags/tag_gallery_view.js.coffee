class EpicImages.Views.TagGallery extends Backbone.View
  template: JST['backbone/templates/tags/tag_gallery']

  attributes:
    class: 'galleryItem'

  events:
    'mouseover' : 'onMouseover'
    'mouseleave'  : 'onMouseleave'
    'click .placeholder' : 'addTagsToPhotosView'

  initialize: ->
    @addPhotosView = @options.addPhotosView

  render: =>
    @$el.html @template @_viewAttributes()
    @_hideCaption()
    @_waitForImageLoad()
    @

  onMouseover: =>
    @$('img').animate opacity: 0.7, 200
    @$('.caption').show().animate top: '-65px', 200, 'easeInOutExpo'

  onMouseleave: =>
    @$('img').animate opacity: 1, 200
    @$('.caption').show().animate top: '0px', 200, 'easeOutQuint', @_hideCaption

  addTagsToPhotosView: => @addPhotosView.applyDefaultTag @model

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

  _viewAttributes: =>
    if @model.get('no_photos')
      show_link = '#photoUpload'
      toggle_modal = 'modal'
    else
      show_link = @model.get('show_link')
      toggle_modal = null
    _.extend {},
      @model.toJSON()
      show_link: show_link
      toggle_modal: toggle_modal

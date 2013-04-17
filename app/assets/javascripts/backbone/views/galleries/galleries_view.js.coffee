class EpicImages.Views.Galleries extends Backbone.View

  # initialize: =>
  #   @$('.galleryItem img').each (index, img) =>
  #     @$(img).wrap('<div class="imageWrapper" />')
  #     @$(img).after("<div class='caption'>#{@$(img).attr('title')}</div>")
  #     @$(img).parents('.galleryItem').hover @galleryHover, @galleryHoverOut

  # galleryHover: (e) =>
  #   @$(e.target).animate opacity: 0.7, 200
  #   @$(e.target).siblings('.caption').animate top: '-60px', 200, 'easeInOutExpo'

  # galleryHoverOut: (e) =>
  #   @$(e.target).animate opacity: 1, 300
  #   @$(e.target).siblings('.caption').animate top: '0px', 100, 'easeOutCirc'

  addOne: (model) =>
    galleryView = new EpicImages.Views.Gallery
      model: model

    @$el.append galleryView.render().el

  render: =>
    @collection.each (model) =>
      @addOne model

    @$el.append '<div class="clear"></div>'
    @
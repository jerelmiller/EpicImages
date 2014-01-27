class EpicImages.Views.TagGalleries extends Backbone.View

  initialize: ->
    @addPhotosView = @options.addPhotosView

  addOne: (model) =>
    galleryView = new EpicImages.Views.TagGallery
      model: model
      addPhotosView: @addPhotosView

    @$el.append galleryView.render().el

  render: =>
    @collection.each (model) =>
      @addOne model

    @$el.append '<div class="clear"></div>'
    @
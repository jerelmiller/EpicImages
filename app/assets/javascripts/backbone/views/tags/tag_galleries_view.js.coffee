class EpicImages.Views.TagGalleries extends Backbone.View

  addOne: (model) =>
    galleryView = new EpicImages.Views.TagGallery
      model: model

    @$el.append galleryView.render().el

  render: =>
    @collection.each (model) =>
      @addOne model

    @$el.append '<div class="clear"></div>'
    @
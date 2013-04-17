class EpicImages.Views.Galleries extends Backbone.View

  addOne: (model) =>
    galleryView = new EpicImages.Views.Gallery
      model: model

    @$el.append galleryView.render().el

  render: =>
    @collection.each (model) =>
      @addOne model

    @$el.append '<div class="clear"></div>'
    @
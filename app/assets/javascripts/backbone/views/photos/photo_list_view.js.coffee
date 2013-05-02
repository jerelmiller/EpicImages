class EpicImages.Views.PhotoList extends Backbone.View
  noPhotos: JST['backbone/templates/photos/no_photos_template']

  initialize: =>
    @listenTo @collection, 'sync', @onSync

  render: =>
    @$el.empty()
    @collection.each @addOne
    _.defer => @$el.append @noPhotos() if @collection.isEmpty()
    @$el.append '<div class="clear"></div>' unless @collection.isEmpty()
    @

  addOne: (photo) =>
    photoView = new EpicImages.Views.Photo
      model: photo

    @$el.append photoView.render().el

  refresh: =>
    @collection.fetch reset: true

  applyMasonry: =>
    @$el.masonry 'destroy' if @$el.data 'masonry'
    @$el.masonry
      itemSelector: '.photo'

  onSync: =>
    @render()
    @applyMasonry()

    @$('.photo').spin()
    @$('.photo').imagesLoaded ($image) =>
      @$('.photo').spin false
      $image.fadeIn()
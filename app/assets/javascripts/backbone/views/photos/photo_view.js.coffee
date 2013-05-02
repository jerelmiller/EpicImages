class EpicImages.Views.Photo extends Backbone.View
  template: JST['backbone/templates/photos/photo_template']

  render: =>
    @$el.html @template @model.toJSON()
    @
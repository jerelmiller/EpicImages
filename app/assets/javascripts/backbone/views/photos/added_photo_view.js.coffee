class EpicImages.Views.AddedPhoto extends Backbone.View
  template: JST['backbone/templates/photos/photo_uploader_template']

  attributes:
    class: 'photoUpload'

  initialize: =>
    @_bindListeners()

  render: =>
    @$el.html @template @_viewAttributes()
    @

  submitImage: =>
    @model.submitImage()

  renderFinished: =>
    @model.set 'progress', 100

  setProgress: (progress) =>
    @model.set 'progress', progress

  showAttributes: =>
    @$('.upload').hide()
    @$('.attributes').show()

  _bindListeners: =>
    @listenTo @model, 'change:progress', @_renderProgress
    @listenTo @model, 'finishedUploading', @showAttributes

  _renderProgress: =>
    @$('.bar').animate
      width: "#{@model.get('progress')}%"

  _viewAttributes: =>
      _.extend {},
        @model.toJSON(),
        name: @model.get('name').truncate 30
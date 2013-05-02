class EpicImages.Views.AddedPhoto extends Backbone.View
  template: JST['backbone/templates/photos/photo_uploader_template']
  imageTemplate: JST['backbone/templates/photos/image_template']

  attributes:
    class: 'photoUpload'

  events:
    'keyup .captionInput'    : 'setCaption'
    'click .resubmit'        : 'resubmit'
    'click input.isFeatured' : 'updateFeatured'

  initialize: =>
    @_bindListeners()
    @setCaption = _.debounce @setCaption, 100

  render: =>
    @$el.html @template @_viewAttributes()
    @$('.tip').tooltip({
      delay:
        show: 800
        hide: 0
    }).on 'hidden', (e) => e.stopPropagation() # fix to prevent bubbling to modal
    @

  setCaption: (e) =>
    @model.set 'caption', @$(e.target).val()

  submitImage: =>
    @model.submitImage()

  setProgress: (progress) =>
    @model.set 'progress', progress

  renderComplete: =>
    @_showImage()
    @_renderTagsInput()
    @$('.upload').hide()
    @$('.attributesContainer').show()

  renderFailed: (callback) =>
    @$('.progress').hide()
    @$('.resubmit').show()
    @$('.name').after '<div class="hint" style="margin-bottom: 5px; color: #E74C2F;">There was an error processing the photo</div>'

  resubmit: =>
    @_resetPhoto()
    @_restartProgress()
    @model.get('image').submit()

  updateFeatured: (e) =>
    @$(e.target).tooltip('hide')
    @model.set 'featured_flag', @$(e.target).is(':checked')

  _restartProgress: =>
    @$('.progress').show()
    @$('.resubmit').hide()

  _bindListeners: =>
    @listenTo @model, 'change:progress', @_renderProgress
    @listenTo @model, 'finishedUploading', @renderComplete
    @listenTo @model, 'change:featured_flag', @_changeChecked

  _renderTagsInput: =>
    tagInputView = new EpicImages.Views.TagInput
      el: '.tagsInput'
      collection: @options.tags

    tagInputView.render()
    tagInputView.registerChangeCallback @_updatePhotoTags

  _updatePhotoTags: (tags) =>
    @model.set 'tags', tags

  _renderProgress: =>
    @$('.bar').animate
      width: "#{@model.get('progress')}%"

  _changeChecked: =>
    return @$('.heart').addClass 'red' if @model.get 'featured_flag'
    @$('.heart').removeClass 'red'

  _viewAttributes: =>
      _.extend {},
        @model.toJSON(),
        name: @model.get('name').truncate 30

  _resetPhoto: =>
    @$('.name').css 'color', '#666'
    @$('.hint').remove()
    @$('.bar').css 'width', 0
    @model.set 'progress', 0

  _showImage: =>
    @$('.attributesContainer').prepend @imageTemplate @model.toJSON()
    _.defer =>
      @$('.photo').spin()
      @$('.photo').imagesLoaded ($image) =>
        @$('.photo').spin false
        $image.fadeIn()
        $image.css 'display', 'block'
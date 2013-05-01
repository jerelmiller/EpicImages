class EpicImages.Views.TagInput extends Backbone.View

  template: JST['backbone/templates/tags/tag_input_template']
  tagTemplate: JST['backbone/templates/tags/tag_template']

  initialize: =>
    @render = _.once @render
    @userTags = new EpicImages.Collections.Tags()

  render: =>
    @$el.html @template _.extend {}, @options, tags: @collection.models, searchedTags: @options.tagData

    @addSelect2()
    @updateView()

  registerChangeCallback: (callback) =>
    @callback = callback

  addSelect2: =>
    _.defer =>
      @$('input#tags').select2
        escapeMarkup: (m) => m
        width: 'element'
        tags: @collection.map(@wrapTag)
        formatSelection: @formatSelection
        placeholder: "Add some tags..."

      @$('input#tags').on 'change', @changeCollection

  updateView: =>
    if @options.tagData
      tags = @options.tagData.map @wrapTag
      @$('input#tags').select2 'data', tags
      @

  createSearchChoice: (term) =>
    @wrapTag(new Analyze.Models.Tag(name: $.trim(term)))

  formatSelection: (object, container) =>
    container.find('a').remove()
    @tagTemplate
      name: object.text

  wrapTag: (tag) =>
    id: tag.get('name') || 'default'
    text: tag.get('name') || 'default'
    tag: tag

  changeCollection: (e) =>
    if e.added
      @userTags.findOrInitialize e.added.text
    else if e.removed
      @_removeTag @userTags.where(name: e.removed.text)[0]

    @callback(@userTags) if @callback

  _removeTag: (tag) =>
    @userTags.remove tag
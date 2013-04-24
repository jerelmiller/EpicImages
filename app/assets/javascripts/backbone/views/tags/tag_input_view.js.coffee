class EpicImages.Views.TagInput extends Backbone.View

  template: JST['backbone/templates/tags/tag_input_template']
  tagTemplate: JST['backbone/templates/tags/tag_template']

  initialize: =>
    @render = _.once @render

  render: =>
    @$el.html @template _.extend {}, @options, tags: @collection.models, searchedTags: @options.tagData

    @$('input#tags').select2
      escapeMarkup: (m) => m
      width: 'element'
      tags: @collection.map(@wrapTag)
      formatSelection: @formatSelection

    @updateView()

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
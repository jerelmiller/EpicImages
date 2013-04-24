class EpicImages.Views.TagSelection extends Backbone.View

  template: JST['backbone/templates/tags/tag_selection_template']
  tagTemplate: JST['backbone/templates/tags/tag_template']

  initialize: =>
    @render = _.once @render

  render: =>
    @$el.html @template _.extend {}, tags: @collection.models, searchedTags: @options.tagData

    @$("select.search").select2
      escapeMarkup: (m) => m
      width: 'element'
      placeholder: 'Search for photos'
      separator: ','
      formatSelection: @formatSelection

    @$("select.search").on 'change', @appendToHiddenField

    @updateView()

  updateView: =>
    if @options.tagData
      tags = @options.tagData.map @wrapTag
      @$("select.search").select2 'data', tags
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

  appendToHiddenField: (e) =>
    vals = _.compact @$('input[name=search]').val().split(';')
    if e.added
      vals.push e.added.text
    else if e.removed
      vals = _.without vals, e.removed.text
    @$('input[name=search]').val vals.join(';')
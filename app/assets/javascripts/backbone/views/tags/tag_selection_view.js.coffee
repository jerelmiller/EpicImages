class EpicImages.Views.TagSelection extends Backbone.View

  template: JST['backbone/templates/tags/tag_selection_template']
  tagTemplate: JST['backbone/templates/tags/tag_template']

  initialize: =>
    @listenTo @collection, 'add remove', @render
    @tagData = @options.tagData || new EpicImages.Collections.Tags()

  render: =>
    @$el.html @template @_viewAttributes()

    @$("select.search").select2
      escapeMarkup: (m) => m
      width: 'element'
      placeholder: @options.placeholder
      separator: ','
      formatSelection: @formatSelection

    @$("select.search").on 'change', @appendToHiddenField

    @updateView()

  updateView: =>
    if @tagData
      tags = @tagData.map @wrapTag
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
    if e.added
      @tagData.findOrInitialize e.added.text
    else if e.removed
      @tagData.remove @tagData.where(name: e.removed.text)[0]
    @$("input[name=#{@options.fieldName}]").val @tagData.map((tag) => tag.get('name')).join(';')

  _viewAttributes: =>
    _.extend {},
      tags: @collection.models
      searchedTags: @tagData
      fieldName: @options.fieldName
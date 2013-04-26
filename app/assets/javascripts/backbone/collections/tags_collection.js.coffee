class EpicImages.Collections.Tags extends Backbone.Collection
  model: EpicImages.Models.Tag

  findOrInitialize: (tagName) =>
    tag = @where(name: tagName)[0] || new EpicImages.Models.Tag name: tagName
    @add tag if tag.isNew()
    tag
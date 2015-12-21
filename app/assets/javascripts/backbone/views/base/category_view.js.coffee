Archivist.Views.Base ||= {}

class Archivist.Views.Base.BaseView extends Backbone.View
  template: JST["backbone/templates/base/category"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this

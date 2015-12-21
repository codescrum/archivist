Archivist.Views.Instruments ||= {}

class Archivist.Views.Instruments.DocView extends Backbone.View
  template: JST["backbone/templates/instruments/doc"]
  template_code_lists: JST["backbone/templates/code_lists/index"]

  render: ->
    @$el.html(@template(@model.toJSON()))
    @codeListsFetched = new $.Deferred
    @code_lists = @model.code_lists
    that = this
    #@code_lists.fetch reset: true, success: ->
      #that.codeListsFetched.resolve()
    #@codeListsFetched.done ->
    that.code_lists_view = new Archivist.Views.CodeLists.IndexView(collection: that.code_lists)
    that.$('#code-lists').html(that.code_lists_view.render().el)
    return this

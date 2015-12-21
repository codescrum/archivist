class Archivist.Routers.CodeListsRouter extends Backbone.SubRoute
  initialize: (options) ->
    @codeListsFetched = new $.Deferred
    @code_lists = options.code_lists
    that = this
    @code_lists.fetch reset: true, success: ->
      that.codeListsFetched.resolve()

  routes:
    "new"      : "newCodeList"
    "index"    : "code_lists_index"
    ":id/edit" : "code_list_edit"
    ":id"      : "code_list_show"
    ".*"        : "code_lists_index"
    ""          : "code_lists_index"

  new_code_list: ->
    that = this
    @codeListsFetched.done ->
      that.view = new Archivist.Views.CodeLists.NewView(collection: that.code_lists)
      Archivist.UI.html(that.view.render().el)

  code_lists_index: ->
    that = this
    @codeListsFetched.done ->
      that.view = new Archivist.Views.CodeLists.IndexView(collection: that.code_lists)
      Archivist.UI.html(that.view.render().el)

  code_list_show: (instrument_id, id) ->
    console.log 'code lists show route'
    that = this
    @codeListsFetched.done ->
      code_list = that.code_lists.get(id)
      that.view = new Archivist.Views.CodeLists.ShowView(model: code_list)
      Archivist.UI.html(that.view.render().el)

  code_list_edit: (instrument_id, id) ->
    that = this
    @codeListsFetched.done ->
      code_list = that.code_lists.get(id)

      that.view = new Archivist.Views.CodeLists.EditView(model: code_list)
      Archivist.UI.html(that.view.render().el)

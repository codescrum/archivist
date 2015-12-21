class Archivist.Models.CodeList extends Backbone.RelationalModel
  initialize: (options) ->
    @set "show_url", @url()
    @set "edit_url", @url() + "/edit"
    @set "destroy_url", @url() + "/destroy"
    @set "code_lists_url", @collection.url

  paramRoot: 'code_list'

  defaults:
    label: null

class Archivist.Collections.CodeListsCollection extends Backbone.Collection
  model: Archivist.Models.CodeList
  url: '/code_lists'

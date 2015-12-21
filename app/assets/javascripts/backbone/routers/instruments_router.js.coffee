class Archivist.Routers.InstrumentsRouter extends Backbone.SubRoute
  initialize: (options) ->
    @instrumentsFetched = new $.Deferred
    @instruments = new Archivist.Collections.InstrumentsCollection()
    that = this
    @instruments.fetch reset: true, success: ->
      that.instrumentsFetched.resolve()

  routes:
    "new"      : "newInstrument"
    "index"    : "instrumentsIndex"
    ":id/edit" : "instrumentEdit"
    ":id"      : "instrumentShow"
    ":id/doc"  : "instrumentDoc"
    ":id/code_lists" : "invokeCodeListsModule"
    ":id/code_lists/*subroute": "invokeCodeListsModule"
    ""         : "instrumentsIndex" 
    ".*"       : "instrumentsIndex"

  routers: {}

  newInstrument: ->
    that = this
    @instrumentsFetched.done ->
      that.view = new Archivist.Views.Instruments.NewView(collection: @instruments)
      Archivist.UI.html(that.view.render().el)

  instrumentsIndex: ->
    that = this
    @instrumentsFetched.done ->
      that.view = new Archivist.Views.Instruments.IndexView(collection: that.instruments)
      Archivist.UI.html(that.view.render().el)

  instrumentShow: (id) ->
    that = this
    @instrumentsFetched.done ->
      instrument = that.instruments.get(id)
      that.view = new Archivist.Views.Instruments.ShowView(model: instrument)
      Archivist.UI.html(that.view.render().el)

  instrumentDoc: (id) ->
    that = this
    @instrumentsFetched.done ->
      instrument = that.instruments.get(id)
      that.view = new Archivist.Views.Instruments.DocView(model: instrument)
      Archivist.UI.html(that.view.render().el)

  instrumentEdit: (id) ->
    instrument = @instruments.get(id)

    @view = new Archivist.Views.Instruments.EditView(model: instrument)
    Archivist.UI.html(@view.render().el)

  invokeCodeListsModule: (id, subroute) ->
    console.log 'codelists module called'
    that = this
    @instrumentsFetched.done ->
      instrument = that.instruments.get(id)
      that.routers.CodeListsRouter = new Archivist.Routers.CodeListsRouter "instruments/:instrument_id/code_lists", {code_lists: instrument.code_lists}

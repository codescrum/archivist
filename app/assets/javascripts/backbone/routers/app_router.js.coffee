class Archivist.Routers.AppRouter extends Backbone.Router
  initialize: ->
    @route ///^instruments///, "invokeInstrumentsModule"

  routes:
    ""    : "index"
#    "instruments/*subroute" : "invokeInstrumentsModule"
    "datasets/*subroute"      : "invokeDatasetsModule"
    "users/*subroute"      : "invokeUsersModule"
    ".*"        : "index"

  routers: {}

  index: ->
    console.log 'index called'
    @view = new Archivist.Views.App.IndexView()
    $("#backbone-UI").html(@view.render().el)

  invokeInstrumentsModule: (subroute) ->
    console.log 'instruments module called'
    @routers.InstrumentsRouter = new Archivist.Routers.InstrumentsRouter "instruments"

  invokeDatasetsModule: (subroute) ->
    @routers.DatasetsRouter = new Archivist.Routers.DatasetsRouter "datasets"

  invokeUsersModule: (subroute) ->
    @routers.UsersRouters = new Archivist.Routers.UsersRouter "users"

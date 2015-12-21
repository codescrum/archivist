class Archivist.Routers.CategoriesRouter extends Backbone.SubRoute
  initialize: (options) ->
    @categoriesFetched = new $.Deferred
    @categories = options.categories
    that = this
    @categories.fetch reset: true, success: ->
      that.categoriesFetched.resolve()

  routes:
    "new"      : "new_category"
    "index"    : "categories_index"
    ":id/edit" : "category_edit"
    ":id"      : "category_show"
    ".*"        : "categories_index"
    ""          : "categories_index"

  new_category: ->
    that = this
    @categoriesFetched.done ->
      that.view = new Archivist.Views.Categories.NewView(collection: that.categories)
      Archivist.UI.html(that.view.render().el)

  categories_index: ->
    that = this
    @categoriesFetched.done ->
      that.view = new Archivist.Views.Categories.IndexView(collection: that.categories)
      Archivist.UI.html(that.view.render().el)

  category_show: (instrument_id, id) ->
    that = this
    @categoriesFetched.done ->
      category = that.categories.get(id)
      that.view = new Archivist.Views.Categories.ShowView(model: category)
      Archivist.UI.html(that.view.render().el)

  category_edit: (instrument_id, id) ->
    that = this
    @categoriesFetched.done ->
      category = that.category.get(id)

      that.view = new Archivist.Views.Categories.EditView(model: category)
      Archivist.UI.html(that.view.render().el)

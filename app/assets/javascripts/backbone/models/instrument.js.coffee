class Archivist.Models.Instrument extends Backbone.RelationalModel
  initialize: ->
    @set "instrument_url", @url()
    @set "edit_instrument_url", @url() + "/edit"
    @set "destroy_instrument_url", @url() + "/destroy"
    @set "instruments_url", @collection.url
    @code_lists = new Archivist.Collections.CodeListsCollection
    @code_lists.url = @url() + "/code_lists"
    @code_lists.on "reset", @updateCounts

  paramRoot: 'instrument'

  defaults:
    agency: null
    version: null
    prefix: null
    label: null
    study: null

#  relations: [
#    {
#      type: Backbone.HasMany
#      key: 'code_lists'
#      keySource: 'instrument_id'
#      relatedModel: 'Archivist.Models.CodeList'
#      collectionType: Archivist.Collections.CodeListCollection
      #reverseRelation:
      #  key: 'instrument_id'
      #  includeInJSON: 'id'
#    }
#  ]

class Archivist.Collections.InstrumentsCollection extends Backbone.Collection
  model: Archivist.Models.Instrument
  url: '/instruments'

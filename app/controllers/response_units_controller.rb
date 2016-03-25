class ResponseUnitsController < ApplicationController
  include BaseInstrumentController

  add_basic_actions require: ':response_unit',
                    params: '[:label]',
                    collection: 'Instrument.find(params[:instrument_id]).response_units'

end
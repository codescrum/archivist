class ResponseDomainCode < ApplicationRecord
  include ResponseDomain
  belongs_to :code_list
  delegate :label, to: :code_list
  before_create :set_instrument

  def set_instrument
    instrument_id = code_list.instrument_id
  end

  def codes
    self.code_list.codes.map do |x|
      {
          label: x.category.label,
          value: x.value,
          order: x.order
      }
    end
  end
end

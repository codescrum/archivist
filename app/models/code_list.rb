class CodeList < ActiveRecord::Base
  belongs_to :instrument
  has_many :codes, -> { includes(:category).order('"order" ASC') }, dependent: :destroy
  has_many :categories, through: :codes
  has_one :response_domain_code, dependent: :destroy

  def response_domain
    self.response_domain_code
  end

  def response_domain=(be_code_answer)
    if be_code_answer && response_domain.nil?
      self.response_domain_code = ResponseDomainCode.new
    end

    if  !(be_code_answer || response_domain.nil?)
      self.response_domain_code.destroy
    end
  end
  
  def is_response_domain?
    not self.response_domain_code.nil?
  end
  alias has_response_domain? is_response_domain?
end

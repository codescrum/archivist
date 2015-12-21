class Instrument < ActiveRecord::Base
  has_many :cc_conditions, dependent: :destroy
  has_many :cc_loops, dependent: :destroy
  has_many :cc_questions, dependent: :destroy
  has_many :cc_sequences, dependent: :destroy
  has_many :cc_statements, dependent: :destroy
  has_many :question_grids, dependent: :destroy
  has_many :question_items, dependent: :destroy
  has_many :code_lists, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :instructions, dependent: :destroy
  has_many :response_domain_datetimes, dependent: :destroy
  has_many :response_domain_numerics, dependent: :destroy
  has_many :response_domain_texts, dependent: :destroy
  has_many :response_units, dependent: :destroy
  
  def conditions
    self.cc_conditions
  end
  
  def loops
    self.cc_loops
  end
  
  def questions
    self.cc_questions
  end
  
  def sequences
    self.cc_sequences
  end
  
  def statements
    self.cc_statements
  end
end
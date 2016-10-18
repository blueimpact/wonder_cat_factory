class Event < ActiveRecord::Base
  include TimeScopes

  belongs_to :product
  belongs_to :bid

  validates :product_id, presence: true

  def self.trigger *_
    raise 'Not Implemented'
  end

  def event_name
    self.class.name.demodulize[/.*(?=Event$)/]
  end

  def instruction
    product.instructions.find_by(type: instruction_type)
  end

  def instruction_type
    "Instructions::#{event_name}Instruction"
  end
end

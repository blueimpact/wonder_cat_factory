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

  def deliver_to_user
    if bid
      EventMailer.to_user(self, bid).deliver_later
    else
      product.bids.older_first.each do |bid|
        EventMailer.to_user(self, bid).deliver_later
      end
    end
  end

  def deliver_to_seller
    EventMailer.to_seller(self).deliver_later
  end
end

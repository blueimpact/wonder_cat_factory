class ProductMessage < ActiveRecord::Base
  belongs_to :product

  enum message_type: {
    enqueued_event: 1000,
    goaled_event: 2000,
    dequeued_event: 3000
  }

  validates :subject, presence: true
  validates :body, presence: true
  validates :message_type, presence: true
end

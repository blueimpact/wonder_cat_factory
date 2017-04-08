class ProductMessage < ActiveRecord::Base
  belongs_to :product

  enum message_type: {
    enqueued_event: 1,
    goaled_event: 2,
    dequeued_event: 3
  }

  validates :subject, presence: true
  validates :body, presence: true
  validates :product, presence: true
  validates :message_type, presence: true, uniqueness: { scope: [:product_id] }
end

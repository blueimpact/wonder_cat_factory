class Bid < ActiveRecord::Base
  include TimeScopes
  include EventTrigger

  belongs_to :user
  belongs_to :product, counter_cache: true
  has_many :events, -> { older_first }, dependent: :destroy

  validates :user, presence: true
  validates :product, presence: true, uniqueness: { scope: :user }

  triggers Events::EnqueuedEvent, :created_at

  def queue_index
    product.bids.where(Bid.arel_table[:created_at].lt(created_at)).count
  end
end

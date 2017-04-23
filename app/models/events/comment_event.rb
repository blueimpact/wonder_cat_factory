class Events::CommentEvent < Events::RegularEvent
  validates :product_id, presence: true

  def self.attach! comment
    binding.pry
    event = create!(product: comment.product, created_at: comment.created_at)
    comment.update!(event: event)
  end
end

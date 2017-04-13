class SystemMessage < ActiveRecord::Base
  belongs_to :user

  enum message_type: {
    started_event: 1,
    enqueued_event: 2,
    goaled_event: 3
  }

  validates :subject, presence: true
  validates :body, presence: true
  validates :message_type, presence: true, uniqueness: { scope: [:user_id] }
end

class SystemMessage < ActiveRecord::Base
  belongs_to :user

  enum message_type: {
    started_event: 1000,
    enqueued_event: 2000,
    goaled_event: 3000
  }

  validates :subject, presence: true
  validates :body, presence: true
  validates :message_type, presence: true
end

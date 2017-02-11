class SystemMessage < ActiveRecord::Base
  belongs_to :user

  enum message_type: {
    started: 1000,
    enqueued: 2000,
    goaled: 3000
  }

  validates :title, presence: true
  validates :body, presence: true
  validates :message_type, presence: true
end

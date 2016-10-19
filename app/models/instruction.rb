class Instruction < ActiveRecord::Base
  belongs_to :product

  validates :type, presence: true
  validates :body, presence: true

  def becomes_base
    becomes(Instruction)
  end
end

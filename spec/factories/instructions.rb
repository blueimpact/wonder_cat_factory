FactoryGirl.define do
  factory :enqueued_instruction, class: 'Instructions::EnqueuedInstruction' do
  end

  factory :dequeued_instruction, class: 'Instructions::DequeuedInstruction' do
  end

  factory :started_instruction, class: 'Instructions::StartedInstruction' do
  end

  factory :goaled_instruction, class: 'Instructions::GoaledInstruction' do
  end
end

FactoryGirl.define do
  factory :started_instruction, class: 'Instructions::StartedInstruction' do
    type 'Instructions::StartedInstruction'
    body 'This is started instruction.'
  end

  factory :goaled_instruction, class: 'Instructions::GoaledInstruction' do
    type 'Instructions::GoaledInstruction'
    body 'This is goaled instruction.'
  end

  factory :enqueued_instruction, class: 'Instructions::EnqueuedInstruction' do
    type 'Instructions::EnqueuedInstruction'
    body 'This is enqueued instruction.'
  end

  factory :dequeued_instruction, class: 'Instructions::DequeuedInstruction' do
    type 'Instructions::DequeuedInstruction'
    body 'This is dequeued instruction.'
  end
end

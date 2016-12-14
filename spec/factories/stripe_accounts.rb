FactoryGirl.define do
  factory :stripe_account do
    user
    publishable_key 'pk_test_xxxxxxxxxxxxxxxxxxxxxxx'
    secret_key 'sk_test_xxxxxxxxxxxxxxxxxxxxxxx'
    stripe_user_id 'acct_xxxxxxxxxxxxxxxxxx'
  end
end

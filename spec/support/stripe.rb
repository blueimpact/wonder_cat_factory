RSpec.configure do |config|
  config.before do
    stub_request(:post, 'https://api.stripe.com/v1/accounts').to_return(
      headers: { 'Content-Type' => 'application/json' },
      body: ' {
        "id": "acct_xxxxxxxxxxxxxxxx",
        "keys": {
          "secret": "sk_test_xxxxxxxxxxxxxxxxxxxxxxxx",
          "publishable": "pk_test_xxxxxxxxxxxxxxxxxxxxxxxx"
        }
      } '
    )
  end
end

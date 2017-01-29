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

    stub_request(:post, 'https://api.stripe.com/v1/customers').to_return(
      headers: { 'Content-Type' => 'application/json' },
      body: ' {
        "id": "cus_xxxxxxxxxxxx",
        "object": "customer",
        "account_balance": 0,
        "created": 1485656258,
        "currency": "usd",
        "default_source": "card_xxxxxxxxxxxxxxxxxxxxx",
        "delinquent": false,
        "description": "5",
        "discount": null,
        "email": null,
        "livemode": false,
        "metadata": {
        },
        "shipping": null,
        "sources": {
          "object": "list",
          "data": [
            {
              "id": "card_xxxxxxxxxxxxxxxxxxxx",
              "object": "card",
              "address_city": null,
              "address_country": null,
              "address_line1": null,
              "address_line1_check": null,
              "address_line2": null,
              "address_state": null,
              "address_zip": null,
              "address_zip_check": null,
              "brand": "Visa",
              "country": "US",
              "customer": "cus_xxxxxxxxxxxxx",
              "cvc_check": "pass",
              "dynamic_last4": null,
              "exp_month": 2,
              "exp_year": 2025,
              "funding": "credit",
              "last4": "4242",
              "metadata": {
              },
              "name": null,
              "tokenization_method": null
            }
          ],
          "has_more": false,
          "total_count": 1,
          "url": "/v1/customers/cus_xxxxxxxxxxxx/sources"
        },
        "subscriptions": {
        "object": "list",
        "data": [],
        "has_more": false,
        "total_count": 0,
        "url": "/v1/customers/cus_xxxxxxxxxxxxx/subscriptions"
        }
      } '
    )
    stub_request(:post, 'https://api.stripe.com/v1/charges').to_return(
      headers: { 'Content-Type' => 'application/json' },
      body: ' {
        "id": "ch_xxxxxxxxxxxxxxxxxxxxxxxxx",
        "object": "charge",
        "amount": 999,
        "amount_refunded": 0,
        "application": null,
        "application_fee": null,
        "balance_transaction": "txn_xxxxxxxxxxxxxxxxxxxxxxx",
        "captured": true,
        "created": 1485657628,
        "currency": "usd",
        "customer": "cus_xxxxxxxxxxxxx",
        "description": null,
        "destination": null,
        "dispute": null,
        "failure_code": null,
        "failure_message": null,
        "fraud_details": {
        },
        "invoice": "in_xxxxxxxxxxxxxxxxxxxxxxxx",
        "livemode": false,
        "metadata": {
        },
        "order": null,
        "outcome": {
          "network_status": "approved_by_network",
          "reason": null,
          "risk_level": "normal",
          "seller_message": "Payment complete.",
          "type": "authorized"
        },
        "paid": true,
        "receipt_email": null,
        "receipt_number": null,
        "refunded": false,
        "refunds": {
          "object": "list",
          "data": [

          ],
          "has_more": false,
          "total_count": 0,
          "url": "/v1/charges/ch_xxxxxxxxxxxxxxxxxxxxxxxxx/refunds"
        },
        "review": null,
        "shipping": null,
        "source": {
          "id": "card_xxxxxxxxxxxxxxxxxxxxxxxxxx",
          "object": "card",
          "address_city": null,
          "address_country": null,
          "address_line1": null,
          "address_line1_check": null,
          "address_line2": null,
          "address_state": null,
          "address_zip": null,
          "address_zip_check": null,
          "brand": "Visa",
          "country": "US",
          "customer": "cus_xxxxxxxxxxxxx",
          "cvc_check": null,
          "dynamic_last4": null,
          "exp_month": 12,
          "exp_year": 2017,
          "funding": "credit",
          "last4": "4242",
          "metadata": {
          },
          "name": null,
          "tokenization_method": null
        },
        "source_transfer": null,
        "statement_descriptor": null,
        "status": "succeeded"
      } '
    )
  end
end

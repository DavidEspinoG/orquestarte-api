require 'base64'

class PayPalController < ApplicationController

  def token 
    render json: {token: get_access_token } , status: :ok
  end

  def create_order
    access_token = get_access_token
    response = Excon.post(
      "https://api-m.sandbox.paypal.com/v2/checkout/orders",
      headers: {
        'Content-Type': 'application/json', 
        Authorization: "Bearer #{access_token}"
      },
      body: JSON.generate({
        "purchase_units": [
          {
            "amount": {
              "currency_code": "MXN", 
              "value": "100.00"
            }
          }
        ],
        "intent": "CAPTURE", 
        "payment_source": {
          "paypal": {
            "experience_context": {
              "brand_name": "Orquestarte Educacion Musical", 
              "return_url": "http://localhost:3000"
            }
          }
        }
      })
    )
    render json: response.body, status: :ok
  end

  private 

  def get_access_token
    url = "https://api-m.sandbox.paypal.com/v1/oauth2/token"
    client_id = Rails.application.credentials.paypal_client_id
    secret = Rails.application.credentials.paypal_secret
    credentials = Base64.strict_encode64("#{client_id}:#{secret}")
    headers = {
      "Content-Type" => "application/x-www-form-urlencoded",
      "Authorization" => "Basic #{credentials}"
    }
    data = "grant_type=client_credentials"
    response = Excon.post(
      url, 
      headers: headers, 
      body: data
    )
    token = JSON.parse(response.body)['access_token']
  end
end

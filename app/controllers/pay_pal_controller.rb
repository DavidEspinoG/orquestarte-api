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
              "value": get_purchase_total
            }
          }
        ],
        "intent": "CAPTURE", 
        "payment_source": {
          "paypal": {
            "experience_context": {
              "payment_method_preference": "IMMEDIATE_PAYMENT_REQUIRED",
              "brand_name": "Orquestarte Educacion Musical",
              "locale": "es-MX",
              "user_action": "PAY_NOW", 
              "return_url": "https://example.com/returnUrl",
              "cancel_url": "https://example.com/returnUrl"
            }
          }
        }
      })
    )
    render json: response.body, status: :ok
  end

  def capture_payment 
    access_token = get_access_token
    order_id = params[:order_id]
    if order_id
      url = "https://api-m.sandbox.paypal.com/v2/checkout/orders/#{order_id}/capture" 
      headers = {
        "Content-Type": "application/json",
        Authorization: "Bearer #{access_token}"
      }
      response = Excon.post(url, headers: headers)
      render json: response.body, status: :ok
    else 
      render json: {message: 'order_id not provided'}, status: :unprocessable_entity
    end
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

  def get_purchase_total 
    cart = params[:cart]
    total = 0
    if cart 
      ids = cart.map {|element| element[:id]}
      ids.each do |id|
        month = Month.find(id);
        if month 
          total += month.price
        end
      end
    end
    total.to_s
  end

end

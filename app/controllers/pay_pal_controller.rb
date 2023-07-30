require 'base64'

class PayPalController < ApplicationController

  def token 
    render json: {token: get_access_token } , status: :ok
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

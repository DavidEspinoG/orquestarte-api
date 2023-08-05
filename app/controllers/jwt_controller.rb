class JwtController < ApplicationController

  def encode
    exp = Time.now.to_i + 4 * 3600
    secret = Rails.application.credentials.secret_key_base
    payload = {
      data: 'Great job',
      exp: exp
    }
    token = JWT.encode payload, secret, 'HS256'
    render json: {token: token}, status: :ok
  end

  def decode 
    secret = Rails.application.credentials.secret_key_base
    begin
      decoded_token = JWT.decode params[:token], secret, true, {algorithm: 'HS256'}
      render json: decoded_token, status: :ok
    rescue
      render json: {message: 'expired token'}, status: :unauthorized
    end
  end

end

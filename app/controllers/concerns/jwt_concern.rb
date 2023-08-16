module JwtConcern 

  extend ActiveSupport::Concern
  
  def generate_token(data)
    exp = Time.now.to_i + 4 * 3600
    secret = Rails.application.credentials.secret_key_base
    payload = {
      data: data,
      exp: exp
    }
    JWT.encode payload, secret, 'HS256'
  end

  def decode 
    secret = Rails.application.credentials.secret_key_base
    token = ''
    begin
      decoded_token = JWT.decode params[:token], secret, true, {algorithm: 'HS256'}
      render json: decoded_token, status: :ok
    rescue
      render json: {message: 'expired token'}, status: :unauthorized
    end
  end
  
end
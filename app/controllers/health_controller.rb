class HealthController < ApplicationController
  
  include JwtConcern 
  
  def index
    render json: {message: 'ok'}, status: :ok
  end

  def fox 
    response = Excon.get('https://randomfox.ca/floof/');
    render json: response.body, status: :ok
  end

  def getJwt
    token = encode
    render json: {token: token}, status: :ok
  end
end

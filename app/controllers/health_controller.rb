class HealthController < ApplicationController
  def index
    render json: {message: 'ok'}, status: :ok
  end

  def fox 
    response = Excon.get('https://randomfox.ca/floof/');
    render json: response.body, status: :ok
  end
end

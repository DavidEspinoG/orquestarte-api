class SchoolsController < ApplicationController

  include JwtConcern

  def index
    user = user_from_token
    if user 
      if user.is_admin
        schools = School.all
        render json: schools, status: :ok
      else
        render json: {message: 'No autorizado'}, status: :unauthorized
      end
    else 
      render json: {message: 'Token inválido o inexistente'}, status: :unauthorized
    end
  end

end

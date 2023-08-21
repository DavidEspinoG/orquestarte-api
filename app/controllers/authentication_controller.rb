class AuthenticationController < ApplicationController

  include JwtConcern

  def login 
    user = User.find_by(email: params[:email])
    if user 
      if user.authenticate(params[:password])
        data = {
          id: user.id,
          name: user.first_name,
          is_admin: user.is_admin
        }
        render json: {
          name: user.first_name, 
          id: user.id, 
          is_admin: user.is_admin,
          token: generate_token(data)
        }, status: :ok
      else 
        render json: {message: 'El correo o la contraseña son incorrectos'}, status: :unauthorized
      end 
    else
      render json: {message: 'El correo o la contraseña son incorrectos'}, status: :unauthorized
    end
  end

  def authenticate 
    puts user_from_token.first_name
  end

end

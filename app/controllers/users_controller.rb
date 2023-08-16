class UsersController < ApplicationController

  include JwtConcern

  def create 
    user = user_from_token
    if user 
      if user.is_admin 
        new_user = User.new(email: params[:email], password: params[:password], 
          first_name: params[:first_name], last_name: params[:last_name])
        if new_user.save
          render json: {message: 'Nuevo usuario creado'}, status: :ok
        else 
          render json: {message: 'El nuevo usuario no ha sido creado', error: new_user.errors.full_messages}, status: :unprocessable_entity
        end
      else
        render json: {message: 'No tiene permiso de crear nuevos usuarios'}, status: :unauthorized
      end
    else 
      render json: {message: 'El usuario no existe'}
    end
  end

end

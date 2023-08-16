class UsersController < ApplicationController

  include JwtConcern

  def index
    user = user_from_token
    if user
      if user.is_admin
        users = User.all
        render json: users, status: :ok
      else 
        render json: {message: 'No estás autorizado a ver esta información'}, status: :unauthorized
      end
    else 
      render json: {message: 'Token inválido'}
    end
  end

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

  def update_password
    user = user_from_token
    if user.is_admin
      to_update = User.find(params[:id])
      to_update.password = params[:new_password]
      if to_update.save
        render json: {message: 'Password actualizado'}, status: :ok
      else
        render json: {message: 'El password no ha sido actualizado',
          errores: to_update.errors.full_messages}
      end
    else
      render json: {message: 'No autorizado'}, status: :unauthorized
    end
  end

end

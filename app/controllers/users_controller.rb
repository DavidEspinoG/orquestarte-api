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
    school = School.find_by(code: params[:school_code])
    if school 
      user = User.new(user_params)
      user.school = school
      if user.save
        render json: {message: 'Usuario creado'}, status: :ok
      else
        render json: {message: user.errors.full_messages}, status: :ok
      end
    else 
      render json: {message: 'Código de escuela incorrecto'}, status: :unprocessable_entity
    end
  end

  def destroy
    if user_from_token.is_admin
      begin
        user = User.find(params[:id])
        if user.destroy 
          render json: {message: 'El usuario ha sido borrado'}, status: :ok
        else 
          render json: {message: 'El usuario no ha sido borrado'}, status: :unprocessable_entity
        end
      rescue
        render json: {message: 'El usuario no existe'}
      end
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

  private 

  def user_params 
    params.require(:user).permit(:first_name, :last_name, :email, 
      :password, :phone_number, :school_code)
  end

end

class StudentsController < ApplicationController

  include JwtConcern 

  def index 
    user = user_from_token
    if user
      if user.is_admin
        students = user.students
        render json: students, status: :ok
      else 
        render json: {message: 'No autorizado'}, status: :ok
      end
    else    
      render json: {message: 'Token inválido'}, status: :ok
    end
  end

  def students_from_user 
    user = user_from_token
    if user 
      students = user.students
      render json: students, status: :ok
    else
      render json: {message: 'Token inválido'}, status: :unauthorized
    end
  end

end

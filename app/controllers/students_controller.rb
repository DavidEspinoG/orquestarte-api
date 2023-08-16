class StudentsController < ApplicationController

  include JwtConcern 

  def index 
    user = user_from_token
    if user 
      students = user.students
      render json: students, status: :ok
    else    
      render json: {message: 'Token inválido'}, status: :ok
    end
  end
end

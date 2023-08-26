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

  def create
    user = user_from_token
    if user
      student = Student.new(student_params)
      student.user = user
      student.school = user.school
      if student.save
        render json: {message: 'Estudiante inscrito con éxito'}, status: :ok
      else 
        render json: {message: student.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {message: 'Token inválido o inexistente'}, status: :unauthorized
    end
  end

  def students_from_user 
    user = user_from_token
    if user 
      students = Student.includes(:months).where(user: user)
      render json: students, include: :months, status: :ok
    else
      render json: {message: 'Token inválido'}, status: :unauthorized
    end
  end

  def destroy 
    user = user_from_token 
    if user
      if user.is_admin
        begin
          student = Student.find(params[:student_id])
          if student.destroy 
            render json: {message: 'Deleted'}, status: :ok
          end
        rescue
          render json: {message: 'Not found'}, status: :unprocessable_entity
        end
      else 
        render json: {message: 'No autorizado'}, status: :ok
      end
    else 
      render json: {message: 'Token inválido'}, status: :unauthorized
    end
  end

  private

  def student_params
    params.require(:student).permit(:first_name, :last_name)
  end

end

class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student, only: [:update, :destroy]

  def index
    @students = current_user.students
  end

  def create
    
    @student = current_user.students.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to students_path, notice: 'Student was successfully created.' }
        format.json { render json: { success: true, student: @student }, status: :created }
      else
        format.html { render :new }
        format.json { render json: { success: false, errors: @student.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to students_path, notice: 'Student was successfully updated.' }
        format.json { render json: { success: true, student: @student } }
      else
        format.html { render :edit }
        format.json { render json: { success: false, errors: @student.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_path, notice: 'Student was successfully deleted.' }
      format.json { render json: { success: true } }
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :subject, :marks)
  end
end
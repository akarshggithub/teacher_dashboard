class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_student, only: [:update, :destroy]

  def index
    @students = current_user.students
  end

  def create
  # Check if a student with the same name and subject already exists
  existing_student = current_user.students.find_by(name: student_params[:name], subject: student_params[:subject])

  if existing_student
    # If student exists, update the marks by adding the new marks to the existing marks
    if existing_student.update(marks: existing_student.marks + student_params[:marks].to_i)
      respond_to do |format|
        format.html { redirect_to students_path, notice: "Record updated for #{existing_student.name}." }
        format.json { render json: { success: true, student: existing_student }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { success: false, errors: existing_student.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  else
    # If no existing student, create a new student record
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
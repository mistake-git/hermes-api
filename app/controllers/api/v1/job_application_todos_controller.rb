class Api::V1::JobApplicationTodosController < ApplicationController
  before_action :set_job_application_todo, only: [:show, :update, :destroy]

  def index
    job_application_todos = current_user.job_application_todos.includes(:job_application)
    render json: job_application_todos, each_serializer: JobApplicationTodoSerializer
  end

  def show
    render json: @job_application_todo
  end

  def create
    @job_application_todo = current_user.job_application_todos.new(job_application_todo_params)
    if @job_application_todo.save
      render json: @job_application_todo, status: :created
    else
      render json: @job_application_todo.errors, status: :unprocessable_entity
    end
  end

  def update
    if @job_application_todo.update(job_application_todo_params)
      render json: @job_application_todo
    else
      render json: @job_application_todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @job_application_todo.destroy
    render json: { status: :ok }
  end

  private

  def set_job_application_todo
    @job_application_todo = current_user.job_application_todos.find(params[:id])
  end

  def job_application_todo_params
    params.require(:job_application_todo).permit(
      :id,
      :job_application_id,
      :name, 
      :deadline, 
      :formatted_deadline,
      :status, 
      :note
    )
  end
end

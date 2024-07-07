class Api::V1::InterviewsController < ApplicationController
  before_action :set_interview, only: [:show, :update, :destroy]

  def index
    interviews = current_user.interviews
    render json: interviews, each_serializer: InterviewSerializer
  end

  def show
    render json: @interview
  end

  def create
    @interview = current_user.interviews.new(interview_params)
    if @interview.save
      render json: @interview, serializer: InterviewSerializer, status: :created
    else
      render json: @interview.errors, status: :unprocessable_entity
    end
  end

  def update
    if interview_params[:interview_items_attributes].present?
      @interview.interview_items.destroy_all
    end
    if @interview.update(interview_params)
      render json: @interview, serializer: InterviewSerializer, status: :ok
    else
      render json: @interview.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @interview.destroy
    render json: { status: :ok }
  end

  private

  def set_interview
    @interview = current_user.interviews.find(params[:id])
  end

  def interview_params
    params.require(:interview).permit(
      :id,
      :name,
      :interview_time_from,
      :interview_time_to,
      :interview_type,
      :interview_url,
      :interview_address,
      :status,
      :job_application_id,
      interview_items_attributes: [:name]
    )
  end
end

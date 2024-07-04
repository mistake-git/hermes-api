class Api::V1::JobApplicationsController < ApplicationController
  before_action :set_job_application, only: [:show, :update, :destroy]

  def index
    job_applications = current_user.job_applications
    render json: job_applications, serializers: JobApplicationSerializer
  end

  def show
    render json: @job_application, serializers: JobApplicationSerializer
  end

  def create
    merged_params = job_application_params.merge(
      user_company_attributes: job_application_params[:user_company_attributes].merge(user_id: current_user.id)
    )
    job_application = current_user.job_applications.new(merged_params)
    
    if job_application.save!
      render json: job_application, serializers: JobApplicationSerializer
    else
      pp job_application.errors
      render json: { errors: job_application.errors }, status: :unprocessable_entity
    end
  rescue => e
    pp "##############"
    pp e
  end

  def update
    if @job_application.update(job_application_params)
      render json: @job_application, serializers: JobApplicationSerializer
    else
      render json: @job_application.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @job_application.destroy
    render json: { status: :ok }
  end

  private

  def set_job_application
    @job_application = JobApplication.find(params[:id])
  end

  def job_application_params
    params.require(:job_application).permit(
      :user_id, 
      :user_company_id, 
      :name, 
      :annual_income, 
      :level_of_interest, 
      :employment_type,
      :reason_for_personal_link,
      :reason_for_interview_link,
      :job_type,
      :status,
      user_company_attributes: [
        :id, :corporate_number, :corporate_name, :corporate_site_url, :industry_id,
        company_links_attributes: [:name, :href]
      ]
    )
  end
end

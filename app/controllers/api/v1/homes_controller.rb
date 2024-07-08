class Api::V1::HomesController < ApplicationController
  def interviews
    interviews = current_user.interviews.where('interview_time_from <= ?', 1.week.from_now).order(interview_time_from: :desc)
    render json: interviews, each_serializer: InterviewSerializer
  end

  def job_application_todos
    job_application_todos = current_user.job_application_todos.where('deadline <= ?', 1.week.from_now).order(deadline: :desc)
    render json: job_application_todos
  end
end

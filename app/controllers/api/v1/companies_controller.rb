class Api::V1::CompaniesController < ApplicationController
  def index
  end

  def show
    company = Company.find_by_name(params[:id])
    if company
      render json: company
    else
      render json: { error: 'Company information not found' }, status: :not_found
    end
  end

  def search
    company_name = params[:company_name]
    companies = Company.search_by_name(company_name)
    if companies
      render json: companies
    else
      render json: { error: 'Company not found' }, status: :not_found
    end
  end
end

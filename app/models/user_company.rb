class UserCompany < ApplicationRecord
  belongs_to :user
  has_many :job_applications, dependent: :destroy
  has_many :company_links, dependent: :destroy
  accepts_nested_attributes_for :company_links, allow_destroy: true

  attr_accessor :location, :postal_code

  def fetch_location
    client = GBizInfo::Client.new
    company_info = client.fetch_company_info(corporate_number)
    company_info.first['location'] if company_info && company_info.first
  end

  def fetch_postal_code
    client = GBizInfo::Client.new
    company_info = client.fetch_company_info(corporate_number)
    company_info.first['postal_code'] if company_info && company_info.first
  end
end



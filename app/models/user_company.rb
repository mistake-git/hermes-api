# == Schema Information
#
# Table name: user_companies
#
#  id               :bigint           not null, primary key
#  corporate_name   :string(255)      not null
#  corporate_number :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  industry_id      :integer          not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_user_companies_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserCompany < ApplicationRecord
  belongs_to :user
  has_many :job_applications, dependent: :destroy
  has_many :company_links, dependent: :destroy
  accepts_nested_attributes_for :company_links, allow_destroy: true
  
  validates :corporate_name, presence: true, length: { maximum: 100 }
  validates :corporate_number, presence: true, length: { maximum: 12 }, uniqueness: true
  validates :industry_id, presence: true

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



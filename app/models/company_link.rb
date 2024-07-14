# == Schema Information
#
# Table name: company_links
#
#  id              :bigint           not null, primary key
#  href            :string(255)
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_company_id :bigint           not null
#
# Indexes
#
#  index_company_links_on_user_company_id  (user_company_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_company_id => user_companies.id)
#
class CompanyLink < ApplicationRecord
  belongs_to :user_company
  
  validates :href, presence: true
  validates :name, presence: true
  validates :user_company_id, presence: true
end

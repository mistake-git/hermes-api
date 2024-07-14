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
class UserCompanySerializer < ActiveModel::Serializer
  attributes :id, :corporate_name, :industry_id, :corporate_number, :location, :postal_code, :company_links_attributes

  def location
    object.fetch_location
  end

  def postal_code
    object.fetch_postal_code
  end

  def company_links_attributes
    ActiveModel::SerializableResource.new(object.company_links, each_serializer: CompanyLinkSerializer)
  end
end

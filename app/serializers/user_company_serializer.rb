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
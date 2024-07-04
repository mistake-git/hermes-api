class Company
  class << self
    def client
      GBizInfo::Client.new
    end

    def search_by_name(name)
      client.search_company_by_name(name)
    end

    def find_by_name(corporate_number)
      client.fetch_company_info(corporate_number)
    end
  end
end

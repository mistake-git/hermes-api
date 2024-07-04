class Company

    def self.client
      GBizInfo::Client.new
    end

    def self.search_by_name(name)
      client.search_company_by_name(name)
    end

    def self.find_by_name(corporate_number)
      client.fetch_company_info(corporate_number)
    end

end

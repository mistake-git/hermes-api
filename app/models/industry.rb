class industry

    def self.list
      client = Resas::Client.new
      broad_industries = client.fetch_broad_industries
    end

end
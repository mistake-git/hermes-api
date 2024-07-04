class industry
  class << self
    def list
      client = Resas::Client.new
      broad_industries = client.fetch_broad_industries
    end
  end
end
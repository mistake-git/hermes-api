require 'faraday'
require 'json'
require 'uri'

class Resas::Client
  API_URL = 'https://opendata.resas-portal.go.jp/api/v1/industries/broad'.freeze

  def initialize
    @token = ENV['RESAS_API_KEY']
    raise 'RESAS_API_KEY is not set' if @token.nil?

    @connection = Faraday.new do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
  end

  def fetch_broad_industries
    response = @connection.get(API_URL) do |req|
      set_headers(req)
    end

    handle_response(response)
  end

  private

  def set_headers(req)
    req.headers['Accept'] = 'application/json'
    req.headers['X-API-KEY'] = @token
  end

  def handle_response(response)
    raise "Error: #{response.status}" unless response.success?

    data = JSON.parse(response.body)
    data['result']
  rescue StandardError => e
    nil
  end
end

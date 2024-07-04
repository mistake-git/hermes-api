require 'faraday'
require 'json'
require 'uri'

module GBizInfo
  class Client
    API_URL = 'https://info.gbiz.go.jp/hojin/v1/hojin'.freeze

    def initialize
      @token = ENV['G_BIZ_INFO_TOKEN']
      raise 'G_BIZ_INFO_TOKEN is not set' if @token.nil?

      @connection = Faraday.new(url: API_URL) do |faraday|
        faraday.request :url_encoded
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end

    def search_company_by_name(company_name)
      encoded_name = URI.encode_www_form_component(company_name)

      response = @connection.get("?name=#{encoded_name}") do |req|
        set_headers(req)
      end

      handle_response(response, 'hojin-infos')
    end

    def fetch_company_info(corporate_number)
      encoded_corporate_number = URI.encode_www_form_component(corporate_number)
      response = @connection.get("#{encoded_corporate_number}") do |req|
        set_headers(req)
      end
      handle_response(response, 'hojin-infos')
    end

    def fetch_certification_info(corporate_number)
      fetch_info(corporate_number, 'certification')
    end

    def fetch_commendation_info(corporate_number)
      fetch_info(corporate_number, 'commendation')
    end

    def fetch_finance_info(corporate_number)
      fetch_info(corporate_number, 'finance')
    end

    def fetch_patent_info(corporate_number)
      fetch_info(corporate_number, 'patent')
    end

    def fetch_procurement_info(corporate_number)
      fetch_info(corporate_number, 'procurement')
    end

    def fetch_subsidy_info(corporate_number)
      fetch_info(corporate_number, 'subsidy')
    end

    def fetch_workplace_info(corporate_number)
      fetch_info(corporate_number, 'workplace')
    end

    private

    def set_headers(req)
      req.headers['Accept'] = 'application/json'
      req.headers['X-hojinInfo-api-token'] = @token
    end

    def handle_response(response, key, index = nil)
      raise "Error: #{response.status}" unless response.success?

      data = JSON.parse(response.body)
      pp data
      index ? data[key][index] : data[key]
    rescue StandardError => e
      nil
    end

    def fetch_info(corporate_number, info_type)
      encoded_corporate_number = URI.encode_www_form_component(corporate_number)
      response = @connection.get("#{encoded_corporate_number}/#{info_type}") do |req|
        set_headers(req)
      end
      handle_response(response, info_type)
    end
  end
end

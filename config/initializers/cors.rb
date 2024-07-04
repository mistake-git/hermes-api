Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://hermes-lake.vercel.app'

    resource "*",
             headers: :any,
             expose: %w[access-token uid client],
             methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
Apipie.configure do |config|
  config.app_name                = "RailsApiMultipleEndpointExample"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  # where is your API defined?
  config.api_controllers_matcher = File.join(Rails.root, "app", "controllers", "api", "**", "*.rb")
end

Rails.application.configure do
  config.middleware.use Rack::LiveReload

  config.action_mailer.default_url_options = { host: ENV['HOST'], port: ENV['PORT'] }
  config.action_mailer.delivery_method = :letter_opener

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_mailer.raise_delivery_errors = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.assets.debug = true

  config.assets.digest = true

  config.assets.raise_runtime_errors = true

end

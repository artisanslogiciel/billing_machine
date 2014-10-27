if %w( production staging ).include? Rails.env
  Backbone::Application.config.middleware.use ExceptionNotification::Rack,
    :email => {
    :email_prefix => "[Dorsale.cc #{Rails.env}] ",
    :sender_address => %{"Dorsale.cc notifier" <postmaster@dorsale.cc>},
    :exception_recipients => %w{ benoit@agilidee.com }
  }
end
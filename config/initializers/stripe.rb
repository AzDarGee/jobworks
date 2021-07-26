Rails.configuration.stripe = {
  :publishable_key => Rails.application.credentials.dig(:stripe, :access_key),
  :secret_key => Rails.application.credentials.dig(:stripe, :secret_access_key)
}

Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_access_key)
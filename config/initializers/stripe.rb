Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_ACCESS_KEY'],
  :secret_key => ENV['STRIPE_SECRET_ACCESS_KEY']
}

Stripe.api_key = ENV['STRIPE_SECRET_ACCESS_KEY']
# App Setup
Assuming an installation of Ruby3.1.0p0 & Rails  7.0.3.1 is installed with the latest postgresql. 

# Initial Setup

1. Setup your environment variables:
   
   `JOBWORKS_HOST`
   `JOBWORKS_DATABASE_PASSWORD`
   `JOBWORKS_DATABASE_NAME`
   `JOBWORKS_USERNAME`
   `DATABASE_URL`
   `AWS_ACCESS_KEY`
   `AWS_SECRET_ACCESS_KEY`
   `STRIPE_ACCESS_KEY`
   `STRIPE_SECRET_ACCESS_KEY`
   `MAPBOX_PUBLIC_API_KEY`
   `RAILS_MASTER_KEY`
   `SECRET_KEY_BASE`

2. Seed database:
`RAILS_ENV=production rails db:seed --trace`

3. Deploy application: `cap production deploy`




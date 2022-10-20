# App Setup
Assuming an installation of Ruby3.1.2 & Rails  7.0.4 is installed with the latest postgresql. 

# Initial Setup

1. Setup your environment variables:

   `rails credentials:edit --environment development`
   
   Set the following environment variables, ask your manager for the keys.

   ```
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
   ```

2. Seed database:
`RAILS_ENV=production rails db:seed --trace`

3. Deploy application: `cap production deploy`



# Working in Windows 11 / WSL2

1. Install Ruby 3.1.0p0 & `bundle install` all gems
2. `yarn install` All the frontend libraries. (Make sure to have Node installed in WSL2).
3. Check if postgres is running, if not, start it:

   `sudo service postgresql status`

   `sudo service postgresql start`

   ps. You can stop the postgres server by the following command:
   
   `sudo service postgresql stop`
4. 


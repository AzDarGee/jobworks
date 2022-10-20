# App Setup
Assuming an installation of Ruby3.1.2 & Rails  7.0.4 is installed with the latest postgresql. 

# Initial Setup - Mac

1. Setup your environment variables:

   `rails credentials:edit --environment development`
   
   Set the following environment variables, ask your manager for the keys.

2. Seed database: 

   Set the user you are seeding the database with `is_admin = true`
   
   `rails db:seed --trace`

3. Deploy application: `cap production deploy`



# Initial Setup - Windows 11 / WSL2

1. Install Ruby 3.1.0p0 & `bundle install` all gems
2. `yarn install` All the frontend libraries. (Make sure to have Node installed in WSL2).
3. Check if postgres is running, if not, start it:

   `sudo service postgresql status`

   `sudo service postgresql start`

   ps. You can stop the postgres server by the following command:
   
   `sudo service postgresql stop`
4. Run these commands to get the database setup and to fill it with initial data:

   ```
      rake db:setup --trace
      rake db:migrate --trace
   ```

5. Run the rails server in one tab & the frontend webpack server in another tab. Work from a third tab.

   Tab 1: `rails s`
   
   Tab 2: `./bin/webpack-dev-server`
   
   Tab 3: `rails c`

   Signup on the Solos App as an Employer. In your third tab, make the user an admin within the rails console.

   For example:
   ```
      u = User.first
      u.is_admin = true
      u.save!
   ```
6. You can now seed the database - check seeds file

   `rake db:seed`



   Any other questions, direct them to management.






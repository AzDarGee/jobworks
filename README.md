# App Setup

1. Install docker on your system
2. Change the database credentials, host, name, & password in the config/database.yml file.
3. `EDITOR="code --wait" rails credentials:edit --environment production` and add the credentials in there.
4. Run `docker-compose up` in the root of your application directory.
5. `docker exec -it template-app_web_1 /bin/sh`
6. `bin/rails server -p 3000 -b 0.0.0.0`
7. In a different terminal window - `docker exec -it template-app_web_1 /bin/sh`, then
   `./bin/webpack-dev-server`
8. Develop your app.

***
** Replace any mention of `template-app` with the name of your app.

** Replace the remote url of github.



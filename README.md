go-deploy-capistrano
====================

Capistrano Files for deploying Go application

# How to use ?

+ Copy these files to your Golang project's directory.
+ Open `Capfile` and choose the required environment (production/staging)
+ Open `config/production.list` or `config/staging.list` and type in the list of servers separated by `\n`.
+ Open `config/deploy.rb` and modify the required parameters like `application name`, `username`, `hooks` etc...
+ And you're good to go! Run `cap deploy:setup && cap deploy`




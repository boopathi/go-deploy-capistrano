go-deploy-capistrano
====================

Capistrano Files for deploying Go application

# How to use ?

## 1. Copy these files to your Golang project's directory.

## 2. Modify `config/deploy.rb`

Open the file `config/deploy.rb and modify the following settings`

+ `:application` (required) Application Name
+ `:user` (required) Username on the server
+ `:default_stage` (default=staging) Choose between the stages production & staging.
+ `:deploy_to` (default=/home/user/application) Specify the location where the application will be deployed

## 3. Update Servers list

+ Based on the `:default_stage` set in the previous step, open the respective file `production.list` or `staging.list`.
+ Add the list of servers separated by a new line character ('\n')

## 4. Deploy:setup

+ run `cap deploy:setup` to set the necessary environment on the servers
+ Note: You need to run this only when the list of servers changes

## 5. Deploy

+ run `cap deploy` to deploy to the servers listed under `:default_stage`




#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Photo::Application.load_tasks

# hack for requirejs-rails on Heroku
ENV['RAILS_GROUPS'] = nil # trick asset rake file into shelling out

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

# Make the resque tasks available to rake and set default environment variables.
require 'resque/tasks'
task 'resque:setup' => :environment

# Adding the resque:scheduler rake task:
require 'resque/scheduler/tasks'

Rails.application.load_tasks

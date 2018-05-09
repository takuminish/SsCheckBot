# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/environment")
job_type :rbenv_bundle_rake, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && bundle exec script/rails rake -e :environment ':task' :output"

set :output, 'log/crontab.log'
set :environment, :development


#1分ごとに動かす
every 2.minutes do
  rake "shortstory:ss_set"
end

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

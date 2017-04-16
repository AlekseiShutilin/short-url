require 'yaml'

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

env_file = File.join("#{path}", 'config', 'application.yml')
puts env_file
if File.exists?(env_file)
  file = YAML.load(File.open(env_file))
  if !file['INTERVAL_TO_CLEAN_ENTITIES'].to_s.nil? &&
      file['INTERVAL_TO_CLEAN_ENTITIES'].to_s.to_i.is_a?(Numeric) &&
      file['INTERVAL_TO_CLEAN_ENTITIES'].to_s.to_i >= 1

    @interval = file['INTERVAL_TO_CLEAN_ENTITIES'].to_s.to_i
  end
else
  @interval = 1440
end

every @interval.minutes do
  runner "Entity.clean_expired_entities"
end

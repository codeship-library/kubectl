require 'json'

env_var_helper_data = JSON.parse(ENV['ENV_VAR_HELPER'])

action = ARGV[0]
case action
when 'count_entries'
  puts env_var_helper_data.count
when 'container_destination'
  i = ARGV[1].to_i
  puts env_var_helper_data[i]['container_destination']
when 'contents'
  i = ARGV[1].to_i
  puts env_var_helper_data[i]['content']
end

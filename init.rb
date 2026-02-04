# plugins/redmine_time_limit/init.rb
Redmine::Plugin.register :redmine_time_limit do
  name 'Redmine Time Limit'
  author 'Your Name'
  description 'Limits time entry logging to recent dates'
  version '0.1.0'
  
  # Add a new permission
  project_module :time_tracking do
    permission :log_time_without_limit, {}, :require => :member
  end
  
  # Add settings
  settings :default => {
    'time_limit_days' => '2'
  }, :partial => 'settings/time_limit_settings'
end

require File.expand_path('../lib/time_entry_patch', __FILE__)

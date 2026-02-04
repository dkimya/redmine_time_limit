# plugins/redmine_time_limit/lib/time_entry_patch.rb
module TimeEntryPatch
  def self.included(base)
    base.class_eval do
      validate :check_time_entry_date_limit
      
      def check_time_entry_date_limit
        # Skip validation if user has unlimited permission
        return if User.current.allowed_to?(:log_time_without_limit, project)
        
        # Get the configured limit from plugin settings
        max_days_ago = Setting.plugin_redmine_time_limit['time_limit_days'].to_i
        max_days_ago = 2 if max_days_ago <= 0 # Default fallback
        
        if spent_on && spent_on < max_days_ago.days.ago.to_date
          errors.add(:spent_on, "cannot be more than #{max_days_ago} days in the past")
        end
      end
    end
  end
end

TimeEntry.include(TimeEntryPatch)

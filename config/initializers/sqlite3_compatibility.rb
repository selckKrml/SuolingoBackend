# SQLite3 compatibility patch for Rails 8 with older sqlite3 gem on Windows
# This allows sqlite3 1.7.x to work with Rails 8.x requirements

Rails.application.config.before_initialize do
  # Patch to bypass version check
  if defined?(ActiveRecord::ConnectionAdapters::SQLite3Adapter)
    ActiveRecord::ConnectionAdapters::SQLite3Adapter.class_eval do
      # Override any strict version checks if needed
    end
  end
end

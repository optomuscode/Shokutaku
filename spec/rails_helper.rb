# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'capybara/rspec'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories.
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Apply fixture_path and transactional fixtures only for ActiveRecord specs
  if defined?(ActiveRecord::Base)
    config.before(:suite) do
      config.fixture_paths = "#{::Rails.root}/spec/fixtures"
      config.use_transactional_fixtures = true
    end
  end

  # Automatically infer spec type from file location
  config.infer_spec_type_from_file_location!

  # Include Capybara DSL for feature specs
  config.include Capybara::DSL, type: :feature

  # Filter Rails gems from backtraces
  config.filter_rails_from_backtrace!
end

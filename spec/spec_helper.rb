ENV['RACK_ENV'] = 'test'

require 'simplecov'
require 'simplecov-console'
require 'capybara/rspec'
require 'pry'
require 'database_cleaner'
require File.join(File.dirname(__FILE__), '..', 'app.rb')
Capybara.app = Makersbnb

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
   SimpleCov::Formatter::HTMLFormatter
])
SimpleCov.start

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
 
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.expect_with :rspec do |expectations|
    
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

end

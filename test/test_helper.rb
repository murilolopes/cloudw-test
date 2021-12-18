# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
SimpleCov.start 'rails'

require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/reporters'

require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation

# then, whenever you need to clean the DB


Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new

NUMBER_OF_PROCESSORS = ENV['PN'].to_i.positive? ? ENV['PN'].to_i : :number_of_processors

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # parallelize(workers: NUMBER_OF_PROCESSORS)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...
  class << self
    alias :context :describe
  end
end

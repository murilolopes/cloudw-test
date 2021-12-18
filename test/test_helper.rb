# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/reporters'
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :truncation
SimpleCov.start 'rails'
Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new

NUMBER_OF_PROCESSORS = ENV['PN'].to_i.positive? ? ENV['PN'].to_i : :number_of_processors

class ActiveSupport::TestCase
  parallelize(workers: NUMBER_OF_PROCESSORS)
  fixtures :all
  FactoryBot.reload
  include FactoryBot::Syntax::Methods

  class << self
    alias :context :describe
  end
end

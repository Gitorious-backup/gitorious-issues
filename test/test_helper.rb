# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

require "minitest/pride"
require "minitest/rails/capybara"
require "minitest/reporters"
require "capybara/poltergeist"
require "capybara-screenshot/minitest"

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, :window_size => [1440, 900])
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Assertions
end

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

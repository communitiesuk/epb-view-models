# frozen_string_literal: true

if /^true$/i.match?(ENV.fetch("COVERAGE", nil))
  require "simplecov"
  SimpleCov.start do
    enable_coverage :branch
    cover "lib/**/*.rb"
  end
end

require "epb_view_models"
require "nokogiri"
require "samples"
require "rexml/document"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  RSpec::Support::ObjectFormatter.default_instance.max_formatted_output_length = nil
end

class FakeStdErr
  attr_accessor :messages

  def initialize
    @messages = []
  end

  def write(msg)
    @messages << msg
  end
end

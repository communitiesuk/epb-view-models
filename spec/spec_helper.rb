# frozen_string_literal: true

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

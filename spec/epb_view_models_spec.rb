# frozen_string_literal: true

RSpec.describe ViewModel do
  it "has a version number" do
    expect(ViewModel::VERSION).not_to be nil
  end
end

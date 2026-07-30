# frozen_string_literal: true

require_relative "lib/epb_view_models/version"

Gem::Specification.new do |spec|
  spec.name          = "epb_view_models"
  spec.version       = EpbViewModels::VERSION
  spec.authors       = ["MHCLG Energy Performance of Buildings"]
  spec.email         = ["mhclg.digital-services@levellingup.gov.uk"]
  spec.summary       = "Library used to parse Energy Performance Certificates (EPC)"
  spec.homepage      = "https://github.com/communitiesuk/epb-view-models"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.4"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir[
    "api/**/*",
    "lib/**/*",
    "README.md",
    "LICENSE",
  ]

  spec.require_paths = %w[lib]

  spec.add_dependency "nokogiri", "~> 1.18"
  spec.add_dependency "rexml", "~> 3.3"
  spec.add_dependency "zeitwerk", "~> 2.6"
end

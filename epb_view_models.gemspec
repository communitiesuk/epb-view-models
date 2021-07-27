# frozen_string_literal: true

require_relative "lib/epb_view_models"

Gem::Specification.new do |spec|
  spec.name          = "epb_view_models"
  spec.version       = ViewModel::VERSION
  spec.authors       = ["MHCLG Energy Performance of Buildings"]
  spec.email         = ["mhclg.digital-services@communities.gov.uk"]
  spec.summary       = "Library used to parse Energy Performance Certificates (EPC)"
  spec.homepage      = "https://github.com/communitiesuk/epb-view-models"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_dependency "nokogiri", "~> 1.11"
  spec.add_dependency "zeitwerk", "~> 2.4.2"
end

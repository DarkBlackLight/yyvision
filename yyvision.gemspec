require_relative "lib/yyvision/version"

Gem::Specification.new do |spec|
  spec.name = "yyvision"
  spec.version = Yyvision::VERSION
  spec.authors = ["liwuqi95"]
  spec.email = ["wuqi.li@mail.utoronto.ca"]
  spec.homepage = "https://github.com/DarkBlackLight/yyvision"
  spec.summary = "YY Vision"
  spec.description = "YY Vision."
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/DarkBlackLight/yyvision"
  spec.metadata["changelog_uri"] = "https://github.com/DarkBlackLight/yyvision"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.3"
  spec.add_dependency "devise", "~> 4.7.3"
end

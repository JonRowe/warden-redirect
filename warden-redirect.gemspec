# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'warden/redirect/version'

Gem::Specification.new do |gem|
  gem.name          = "warden-redirect"
  gem.version       = Warden::Redirect::VERSION
  gem.authors       = ["Jon Rowe"]
  gem.email         = ["hello@jonrowe.co.uk"]
  gem.description   = %q{Simple gem for throwing redirects in warden.}
  gem.summary       = %q{Simple gem for throwing redirects in warden.}
  gem.homepage      = "https://github.com/JonRowe/warden-redirect.git"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'warden'

  gem.add_development_dependency 'rspec'

end

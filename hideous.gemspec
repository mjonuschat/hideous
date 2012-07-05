# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hideous/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Morton Jonuschat"]
  gem.email         = ["yabawock@gmail.com"]
  gem.description   = %q{Hide/Obfuscate ActiveRecord IDs in a url using a modified Knuth hash}
  gem.summary       = %q{A simple Rails plugin to obfuscate ActiveRecord IDs a bit}
  gem.homepage      = "https://github.com/yabawock/hideous"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hideous"
  gem.require_paths = ["lib"]
  gem.version       = Hideous::VERSION
end

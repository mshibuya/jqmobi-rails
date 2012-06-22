# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jqmobi/rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["M.Shibuya"]
  gem.email         = ["mit.shibuya@gmail.com"]
  gem.description   = %q{This gem provides jQMobi and jQMobi-ujs driver for Rails3 application.}
  gem.summary       = %q{jQMobi integration for Rails.}
  gem.homepage      = "https://github.com/mshibuya/jqmobi-rails"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "jqmobi-rails"
  gem.require_paths = ["lib"]
  gem.version       = Jqmobi::Rails::VERSION
end

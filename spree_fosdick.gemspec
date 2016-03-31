# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_fosdick'
  s.version     = '1.0.1'
  s.summary     = 'Integrate your spree store with Fosdick'
  s.description = s.summary
  s.required_ruby_version = '>= 2.1'

  s.author    = 'Manuel Martinez'
  s.email     = 'vmmf08@gmail.com'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.3.0'
  s.add_dependency 'net-sftp'

  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'rspec-rails',  '~> 3.1'
  s.add_development_dependency 'sass-rails', '~> 4.0.2'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
end

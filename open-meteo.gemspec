lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'open_meteo/version'

Gem::Specification.new do |spec|
  spec.name                  = 'open-meteo'
  spec.version               = OpenMeteo::VERSION
  spec.platform              = Gem::Platform::RUBY
  spec.authors               = ['Peter Morgenstern']
  spec.email                 = ['gundel.peter@gmail.com']
  spec.summary               = 'A client for OpenMeteo weather data'
  spec.homepage              = 'https://github.com/open-meteo-ruby/open-meteo-ruby'
  spec.license               = 'MIT'

  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }

  spec.files                 = `git ls-files -- lib/*`.split("\n")
  spec.require_paths         = ['lib']

  spec.required_ruby_version = '>= 2.7'

  spec.add_dependency 'faraday', '>= 2.0.0'
end

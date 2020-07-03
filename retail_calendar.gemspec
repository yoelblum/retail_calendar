# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'retail_calendar/version'

Gem::Specification.new do |spec|
  spec.name          = 'retail_calendars'
  spec.version       = RetailCalendar::VERSION
  spec.authors       = ['Joel Blum']
  spec.email         = ['yoelblumenator@gmail.com']
  spec.required_ruby_version = '~> 2.4'
  spec.summary       = 'Implements retail calendar'
  spec.description   = 'Supports 445, 454 and 544 calendars'
  spec.homepage      = 'https://github.com/yoelblum/retail_calendar'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/yoelblum/retail_calendar'
    spec.metadata['changelog_uri'] = 'http://todo.com'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.86.0'
  spec.add_dependency 'activesupport', '>=3', '<7'
end

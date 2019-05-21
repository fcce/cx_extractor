lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cx_extractor/version'

Gem::Specification.new do |spec|
  spec.name          = 'cx_extractor'
  spec.version       = CxExtractor::VERSION
  spec.authors       = ['Feng Ce']
  spec.email         = ['kalelfc@gmail.com']

  spec.summary       = ' '
  spec.description = <<-CONTENT
Used to extract text from the web page.
This tool is appropriate for the web page which contains lots of text.
  CONTENT
  spec.homepage      = 'https://fcce.github.io/cx_extractor/'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://fcce.github.io/cx_extractor'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'gruff', '~> 0.7.0'
  spec.add_dependency 'nokogiri', '~> 1.0'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'charlock_holmes'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'typhoeus'
end

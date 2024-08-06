lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cx_extractor/version'

Gem::Specification.new do |spec|
  spec.name          = 'cx_extractor'
  spec.version       = CxExtractor::VERSION
  spec.authors       = ['Feng Ce']
  spec.email         = ['kalelfc@gmail.com']

  spec.summary       = 'Used to extract text from the web page.'
  spec.description = <<-CONTENT
Used to extract text from the web page.
This tool is appropriate for the web page which contains lots of text.
  CONTENT
  spec.homepage      = 'https://fcce.github.io/cx_extractor/'
  spec.license       = 'MIT'
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'gruff'
  spec.add_dependency 'nokogiri'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'charlock_holmes'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'typhoeus'
end

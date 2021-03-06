lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name    = "fluent-plugin-force-encoding"
  spec.version = "0.1.0"
  spec.authors = ["okkez"]
  spec.email   = ["okkez000@gmail.com"]

  spec.summary       = %q{Force encoding specific fields}
  spec.description   = %q{Force encoding speficic fields}
  spec.homepage      = "https://github.com/okkez/fluent-plugin-force-encoding"
  spec.license       = "Apache-2.0"

  test_files, files  = `git ls-files -z`.split("\x0").partition do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.files         = files
  spec.executables   = files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = test_files
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit", "~> 3.0"
  spec.add_runtime_dependency "fluentd", [">= 1.7.4", "< 2"]
end

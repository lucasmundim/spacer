# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "spacer/version"

Gem::Specification.new do |s|
  s.name        = "spacer"
  s.version     = Spacer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lucas Roxo Mundim"]
  s.email       = ["lucas.mundim@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Basic Space Shooter}
  s.description = %q{A Space Shooter sandbox to try things out}

  s.rubyforge_project = "spacer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_runtime_dependency(%q<chingu>, ["~> 0.8.1"])
end

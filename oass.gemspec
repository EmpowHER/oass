# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "oass/version"

Gem::Specification.new do |s|
  s.name        = "oass"
  s.version     = Oass::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rodrigo Navarro"]
  s.email       = ["navarro@manapot.com.br"]
  s.homepage    = ""
  s.summary     = %q{Funny API to access OAS hellish soap interface}
  s.description = %q{Help you to communicate with the corporate advertisers world!}

  s.rubyforge_project = "oass"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "savon", "~> 0.9.2"
  s.add_dependency "nokogiri", "> 1.4.4"
  s.add_dependency "activesupport", "> 3.0.0"
end

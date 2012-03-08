# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "capistrano-recipies/version"

Gem::Specification.new do |s|
  s.name        = "capistrano-recipies"
  s.version     = Capistrano::Recipies::VERSION
  s.authors     = ["John Hwang"]
  s.email       = ["johnyhwang@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Collection of Capistrano Recipies}
  s.description = %q{Collection of Capistrano Recipies}

  s.rubyforge_project = "capistrano-recipies"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'capistrano'
  s.add_dependency 'whenever'
end

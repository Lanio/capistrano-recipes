# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "capistrano-recipes/version"

Gem::Specification.new do |s|
  s.name        = "capistrano-recipes"
  s.version     = Capistrano::Recipes::VERSION
  s.authors     = ["John Hwang"]
  s.email       = ["johnyhwang@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Collection of Capistrano Recipes}
  s.description = %q{Collection of Capistrano Recipes}

  s.rubyforge_project = "lanio-capistrano-recipes"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'capistrano'
  s.add_dependency 'whenever'
end

# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_tree/version"

Gem::Specification.new do |s|
  s.name        = "simple_tree"
  s.version     = SimpleTree::VERSION
  s.authors     = ["yinghai"]
  s.email       = ["yinghai.zhao@mosaic.com"]
  s.homepage    = "http://github.com/mosaicxm/simple-tree"
  s.summary     = %q{simple tree gem}
  s.description = %q{simple tree gem}

  s.rubyforge_project = "simple_tree"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency 'with_model'
  s.add_development_dependency 'rails', '~> 3.0.9'
  s.add_development_dependency 'sqlite3'
  # s.add_runtime_dependency "rest-client"
end

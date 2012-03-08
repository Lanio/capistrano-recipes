require "capistrano-recipes/version"

require 'capistrano'
require 'capistrano/cli'
require 'helpers'

config = Capistrano::Configuration.instance(true)
Dir.glob(File.join(File.dirname(__FILE__), '/recipes/*.rb')).sort.each { |f| config.load(f) }
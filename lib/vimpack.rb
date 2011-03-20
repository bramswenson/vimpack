require "bundler/setup"

# stdlib
require 'fileutils'
require 'tempfile'
require 'erb'
require 'pathname'

# TODO: do i really need active model?
require 'active_model'
require 'trollop'
# TODO: term-ascicolor is required by rails/rspec/cuke 
# or something in rails stack me thinks...maybe us it instead
require 'rainbow'
require 'childprocess'
require 'rest_client'
# TODO: let active support figure out what json to use
require 'yajl'
require 'enviro'

# vimpack
require 'vimpack/utils'
module Vimpack
  include Enviro::Environate

  def self.root
    @root ||= Vimpack::Utils::FilePath.new(File.join(File.dirname(__FILE__), '..'))
  end

  autoload :Models,   'vimpack/models'
  autoload :Commands, 'vimpack/commands'
end


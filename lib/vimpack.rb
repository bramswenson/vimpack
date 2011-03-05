require "bundler/setup"

# stdlib
require 'fileutils'
require 'tempfile'
require 'erb'
require 'pathname'

# FIXME: this line doesn't seem to be working right
# hence the requires of 3rd parties below it
Bundler.require(:default)
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

# vimpack
require 'vimpack/utils'

module Vimpack
  
  def self.root
    @root ||= Utils::FilePath.new(File.join(File.dirname(__FILE__), '..'))
  end

end

require 'vimpack/api'
require 'vimpack/commands'


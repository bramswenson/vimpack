require "rubygems"
require "bundler/setup"
require 'trollop'
require 'rainbow'
require 'childprocess'
require 'fileutils'
require 'erb'
require 'rest_client'
require 'active_model'
require 'yajl'
require 'tempfile'

require 'vimpack/utils'

module Vimpack
  
  def self.root
    @root ||= Utils::FilePath.new(File.join(File.dirname(__FILE__), '..'))
  end

end

require 'vimpack/api'
require 'vimpack/commands'


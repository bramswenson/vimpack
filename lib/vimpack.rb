require 'fileutils'
require 'tempfile'
require 'erb'
require 'pathname'
require 'open-uri'
require 'cgi'

require "bundler/setup"
#Bundler.require :default

require 'active_model'
require 'trollop'
# TODO: term-ascicolor is required by rails/rspec/cuke
# or something in rails stack me thinks...maybe us it instead
require 'rainbow'
require 'childprocess'
# TODO: let active support figure out what json to use
require 'yajl'
require 'enviro'
require 'nokogiri'
require 'octokit'

# vimpack
module Vimpack
  include Enviro::Environate

  autoload :Models,   'vimpack/models'
  autoload :Commands, 'vimpack/commands'
  module Utils
    autoload :FilePath,   'vimpack/utils/file_path'
    autoload :File,       'vimpack/utils/file'
    autoload :Io,         'vimpack/utils/io'
    autoload :Process,    'vimpack/utils/process'
    autoload :Git,        'vimpack/utils/git'
    autoload :Api,        'vimpack/utils/api'
    autoload :Vimscripts, 'vimpack/utils/vimscripts'
    autoload :Github,     'vimpack/utils/github'
  end

  def self.root
    @root ||= Vimpack::Utils::FilePath.new(File.join(File.dirname(__FILE__), '..'))
  end

end



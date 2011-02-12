require 'vimpack/utils/file_path'
require 'vimpack/utils/file'
require 'vimpack/utils/process'
require 'vimpack/utils/io'
require 'vimpack/utils/git'

module Vimpack
  module Utils
    include File
    include Process
    include Io
    include Git
  end
end


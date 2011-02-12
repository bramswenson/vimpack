require 'trollop'
require 'rainbow'
require 'childprocess'
require 'fileutils'
require 'erb'

require 'vimpack/utils'

module Vimpack
  
  def self.root
    @root ||= Utils::FilePath.new(File.join(File.dirname(__FILE__), '..'))
  end

end

require 'vimpack/commands'
require 'vimpack/cli'


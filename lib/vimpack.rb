require 'vimpack/utils/file_path'

module Vimpack

  def self.root
    @root ||= Vimpack::Utils::FilePath.new(File.join(File.dirname(__FILE__), '..'))
  end

end

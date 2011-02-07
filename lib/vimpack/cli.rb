module Vimpack
  class CLI < Thor
    include Thor::Actions
    source_root(File.join(File.dirname(__FILE__), '..', '..'))
    desc 'init', 'initializes vimpack environment backing up the current environment'
    def init
      Vimpack::Commands::Init.run(self)
    end
  end
end

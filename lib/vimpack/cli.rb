module Vimpack
  class CLI
    #source_root(File.join(File.dirname(__FILE__), '..', '..'))
    #desc 'init', 'initializes vimpack environment backing up the current environment'
    def init
      Vimpack::Commands::Init.run(self)
    end
    #desc 'search <pattern>', 'searches vimpack.org for scripts'
    def search(pattern)
      Vimpack::Commands::Search.run(self, pattern)
    end
  end
end

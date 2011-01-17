module Vimpack
  class CLI < Thor
    include Vimpack::Utils
    desc 'init', 'initializes vimpack environment backing up the current environment'
    def init
      Vimpack::Commands::Init.run(self)
    end
  end
end

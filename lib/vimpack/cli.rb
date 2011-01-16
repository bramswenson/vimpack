module Vimpack
  class CLI < Thor
    desc "init", "initializes vimpack environment backing up the current environment"
    def init
      say "vimpack initialized!", :green
    end
  end
end

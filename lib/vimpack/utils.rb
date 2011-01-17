module Vimpack
  module Utils
    def homedir
      @homedir ||= ENV['HOME']
    end

    def homedir=(path)
      @homedir = path
    end

    def dotvim_exists?
      File::directory?(File.join(homedir, '.vim'))
    end
  end
end

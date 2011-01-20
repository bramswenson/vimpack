require 'fileutils'
module Vimpack
  module Commands
    class Init
      include Vimpack::Utils::Paths
      def initialize(app, home_dir=nil)
        @app = app
        @home_dir = home_dir
      end

      def run
        unless vimpack_dir_exists?
          @app.say('backing up existing vim environment', :cyan)
          backup_prexisting_vim_environment
          setup_vimpack_environment
          @app.say('vimpack initialized!', :green) 
        else
          @app.say('vimpack  has already been initialized!', :red) 
        end
      end

      def self.run(app)
        Init.new(app).run
      end

      private
      def setup_vimpack_environment
        # create needed directories
        FileUtils.mkdir_p([ vimpack_dir, vim_dir ])
      end

      def backup_prexisting_vim_environment
        # backup .vim and .vimrc_file
        if vim_dir_exists?
          @app.say('backing up existing .vim directory', :cyan)
          FileUtils.mv(vim_dir, vim_dir + '.before_vimpack')
        end
        if vimrc_file_exists?
          @app.say('backing up existing .vimrc file', :cyan)
          FileUtils.mv(vimrc_file, vimrc_file + '.before_vimpack')
        end
      end
    end
  end
end

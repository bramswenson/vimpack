require 'fileutils'
module Vimpack
  module Commands
    class Init
      def initialize(app, home_dir=nil)
        @app = app
        @app.destination_root = home_dir || ENV['HOME']
      end

      def run
        return nil if File::directory?(File.join(@app.destination_root, '.vimpack'))
        backup_existing_vim_environment
        initialize_vimpack_repo
        @app.say('vimpack initialized!', :cyan)
      end

      def self.run(app)
        Init.new(app).run
      end

      private
      def initialize_vimpack_repo
        @app.say(' * initializing vimpack repo', :cyan)
        %w{ autoload bundle }.each do |directory|
          FileUtils.mkdir_p(File.join(@app.destination_root, '.vimpack', 'vim', directory))
        end
        @app.run("git init #{File.join(@app.destination_root, '.vimpack')}", :verbose => false)
        @app.create_link('.vim', File.join('.vimpack', 'vim'), :verbose => false)
        initialize_pathogen_submodule
        initialize_vimrc
      end

      def initialize_pathogen_submodule
        @app.say(' * initializing pathogen', :cyan)
        @app.run("cd #{File.join(@app.destination_root, '.vimpack')} && git submodule add git@github.com:vim-scripts/pathogen.vim pathogen && git submodule init && git submodule update; cd -", :verbose => false)
        @app.create_link(File.join('.vimpack', 'vim', 'autoload', 'pathogen.vim'), 
                         File.join(@app.destination_root, '.vimpack', 'pathogen', 'plugin', 'pathogen.vim'),
                         :verbose => false)
      end

      def initialize_vimrc
        @app.say(' * initializing .vimrc', :cyan)
        @app.template('tt/vimrc.tt', File.join(@app.destination_root, '.vimpack', 'vimrc'), :verbose => false)
        @app.create_link('.vimrc', File.join(@app.destination_root, '.vimpack', 'vimrc'),
                         :verbose => false)
      end

      def backup_existing_vim_environment
        @app.say(' * backing up existing vim environment', :cyan)
        # backup .vim and .vimrc_file
        vim_path = File.join(@app.destination_root, '.vim')
        vimrc_path = File.join(@app.destination_root, '.vimrc')
        @vimpackrc_contents = File.read(vimrc_path)
        if File::directory?(vim_path)
          FileUtils.mv(vim_path, vim_path + '.before_vimpack')
        end
        if File.exists?(vimrc_path)
          FileUtils.mv(vimrc_path, vimrc_path + '.before_vimpack')
        end
      end
    end
  end
end

module Vimpack
  module Commands
    class Init < Command
      def run
        die!("vimpack appears to already be initialized") if directory_exists?('.vimpack')
        backup_existing_vim_environment
        initialize_vimpack_repo
        say('vimpack initialized!')
      end

      private
      def backup_existing_vim_environment
        say(' * backing up existing vim environment')
        move_path('.vim', '.vim.before_vimpack')
        @vimrc_contents = ''
        if file_exists?('.vimrc')
          @vimrc_contents = ::File.read(home.join('.vimrc'))
          move_path('.vimrc', '.vimrc.before_vimpack')
        end
      end

      def initialize_vimpack_repo
        say(' * initializing vimpack repo')
        %w{ autoload bundle }.each do |directory|
          make_dir('.vimpack', 'vim', directory)
        end
        create_vimpack_repo
        create_link(::File.join('.vimpack', 'vim'), '.vim')
        initialize_pathogen_submodule
        initialize_vimrc
      end

      def initialize_pathogen_submodule
        say(' * initializing pathogen')
        initialize_submodule('http://github.com/vim-scripts/pathogen.vim.git', 'pathogen.vim', '.vimpack')
        create_link(::File.join('.vimpack', 'pathogen.vim', 'plugin', 'pathogen.vim'),
                    ::File.join('.vimpack', 'vim', 'autoload', 'pathogen.vim'))
      end

      def initialize_vimrc
        say(' * initializing .vimrc')
        template('vimrc', ::File.join('.vimpack', 'vimrc'))
        create_link(::File.join('.vimpack', 'vimrc'), '.vimrc')
      end

    end
  end
end

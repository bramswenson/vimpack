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
        FileUtils.mv(pack_path('.vim'), pack_path('.vim.before_vimpack')) if directory_exists?('.vim')
        @vimrc_contents = ''
        if file_exists?('.vimrc')
          @vimrc_contents = File.read(pack_path('.vimrc'))
          FileUtils.mv(pack_path('.vimrc'), pack_path('.vimrc.before_vimpack'))
        end
      end

      def initialize_vimpack_repo
        say(' * initializing vimpack repo')
        %w{ autoload bundle }.each do |directory|
          FileUtils.mkdir_p(pack_path('.vimpack', 'vim', directory))
        end
        run_process_or_die!("git init #{pack_path('.vimpack')}")
        create_link(pack_path('.vimpack', 'vim'), pack_path('.vim'))
        initialize_pathogen_submodule
        initialize_vimrc
      end

      def initialize_pathogen_submodule
        say(' * initializing pathogen')
        run_process_or_die!('git submodule add git@github.com:vim-scripts/pathogen.vim pathogen', 
                            pack_path('.vimpack'))
        create_link(pack_path('.vimpack', 'pathogen', 'plugin', 'pathogen.vim'),
                    pack_path('.vimpack', 'vim', 'autoload', 'pathogen.vim'))
      end

      def initialize_vimrc
        say(' * initializing .vimrc')
        template('vimrc', pack_path('.vimpack', 'vimrc'))
        create_link(pack_path('.vimpack', 'vimrc'), pack_path('.vimrc'))
      end

    end
  end
end

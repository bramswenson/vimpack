module Vimpack
  module Commands
    class Init < Command
      def initialize_commands
        die!("init takes a single optional argument") if @commands.size > 1
        @repo_url = @commands.size == 1 ? @commands[0] : nil
      end

      def run
        exit_with_error!("vimpack appears to already be initialized") if directory_exists?('.vimpack')
        backup_existing_vim_environment
        @repo_url.nil? ? initialize_vimpack_repo : initialize_vimpack_remote_repo
        create_link(self.vim_path.to_s, self.home_path.join('.vim'))
        initialize_vimrc
        say('vimpack initialized!')
      end

      private
      def backup_existing_vim_environment
        say(' * backing up existing vim environment')
        move_path(self.home_path.join('.vim'), self.home_path.join('.vim.before_vimpack'))
        @vimrc_contents = ''
        if file_exists?(self.home_path.join('.vimrc'))
          @vimrc_contents = ::File.read(self.home_path.join('.vimrc'))
          move_path(self.home_path.join('.vimrc'), self.home_path.join('.vimrc.before_vimpack'))
        end
      end

      def initialize_vimpack_repo
        say(' * initializing vimpack repo')
        %w{ autoload bundle }.each do |directory|
          make_dir(self.vim_path.join(directory))
        end
        make_dir(self.script_path.to_s)
        create_vimpack_repo
        initialize_pathogen_submodule
      end

      def initialize_vimpack_remote_repo
        say(' * initializing vimpack repo from git url')
        repo_clone(@repo_url, self.pack_path.to_s)
        init_submodule
        update_submodule
      end

      def initialize_pathogen_submodule
        install_script('pathogen.vim', false)
        create_link(self.script_path.join('pathogen.vim', 'plugin', 'pathogen.vim'),
                    self.vim_path.join('autoload', 'pathogen.vim'))
      end

      def initialize_vimrc
        say(' * initializing .vimrc')
        template('vimrc', self.pack_path.join('vimrc'))
        create_link(self.pack_path.join('vimrc'), self.home_path.join('.vimrc'))
      end

    end
  end
end

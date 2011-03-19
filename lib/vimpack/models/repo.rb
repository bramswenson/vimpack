module Vimpack
  module Models

    class Repo < Base
      class AlreadyInitialized < StandardError ; end
      class << self

        include ::Vimpack::Utils::File
        include ::Vimpack::Utils::Git
        include ::Vimpack::Utils::Scripts

        def initialize_repo!(repo_url=nil)
          raise AlreadyInitialized if initialized?
          @repo_url = repo_url
          backup_existing_vim_environment
          @repo_url.nil? ? initialize_vimpack_repo : initialize_vimpack_remote_repo
        end

        def initialized?
          directory_exists?(home_path.join('.vimpack'))
        end

        private
        def initialize_vimpack_remote_repo
          repo_clone(@repo_url, self.pack_path.to_s)
          init_submodule
          update_submodule
          link_dot_vim
          initialize_vimrc
        end

        def backup_existing_vim_environment
          move_path(home_path.join('.vim'), home_path.join('.vim.before_vimpack'))
          move_path(home_path.join('.vimrc'), home_path.join('.vimrc.before_vimpack'))
        end

        def initialize_vimpack_repo
          %w{ autoload bundle }.each do |directory|
            make_dir(vim_path.join(directory))
          end
          make_dir(script_path.to_s)
          create_vimpack_repo
          initialize_pathogen_submodule
          link_dot_vim
          initialize_vimrc
        end

        def link_dot_vim
          create_link(self.vim_path.to_s, self.home_path.join('.vim'))
        end

        def initialize_pathogen_submodule
          install_script('pathogen.vim', false)
          create_link(script_path.join('pathogen.vim', 'plugin', 'pathogen.vim'),
                      vim_path.join('autoload', 'pathogen.vim'))
        end

        def create_vimpack_repo
          init_repo(pack_path)
        end

        def initialize_vimrc
          template('vimrc', self.pack_path.join('vimrc'))
          create_link(self.pack_path.join('vimrc'), self.home_path.join('.vimrc'))
        end


      end
      setup_paths(ENV['HOME'])


    end

  end
end
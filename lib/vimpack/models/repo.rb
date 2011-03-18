module Vimpack
  module Models

    class Repo < Base
      class AlreadyInitialized < StandardError ; end
      class << self

        include ::Vimpack::Utils::File
        include ::Vimpack::Utils::Git
        include ::Vimpack::Utils::Scripts

        def initialize_repo!
          raise AlreadyInitialized if directory_exists?(home_path.join('.vimpack'))
          backup_existing_vim_environment
          initialize_vimpack_repo
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
        end

        def initialize_pathogen_submodule
          install_script('pathogen.vim', false)
          create_link(script_path.join('pathogen.vim', 'plugin', 'pathogen.vim'),
                      vim_path.join('autoload', 'pathogen.vim'))
        end

        def create_vimpack_repo
          init_repo(pack_path)
        end

      end
      setup_paths(ENV['HOME'])


    end

  end
end

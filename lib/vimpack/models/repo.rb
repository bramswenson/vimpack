module Vimpack
  module Models

    class Repo < Base
      class AlreadyInitialized < StandardError ; end
      class NotInitialized < StandardError ; end
      class OriginRemoteUnset < StandardError ; end

      class << self
        include ::Vimpack::Utils::File
        include ::Vimpack::Utils::Git

        def initialize!(repo_url=nil)
          raise_if_initialized!
          @repo_url = repo_url
          backup_existing_vim_environment
          @repo_url.nil? ? initialize_vimpack_repo : initialize_vimpack_remote_repo
        end

        def initialized?
          directory_exists?(pack_path.to_s)
        end

        def raise_if_initialized!
          raise AlreadyInitialized if initialized?
        end

        def raise_unless_initialized!
          raise NotInitialized unless initialized?
        end

        def publish!(message)
          raise OriginRemoteUnset unless origin_set?
          repo_add_dot
          repo_commit(message)
          repo_push
          true
        end

        def git_exec(subcommand, commands)
          repo_exec(subcommand, commands)
        end

        def installed_script_names
          Dir.glob(script_directories).each.inject([]) do |scripts, script_dir|
            script_name = ::File.split(script_dir)[-1]
            scripts << script_name unless script_name == 'pathogen.vim'
            scripts
          end
        end

        def installed_scripts
          installed_script_names.each.inject([]) do |scripts, script_name|
            scripts << Script.info(script_name)
          end
        end

        private
        def script_directories
          Script::SCRIPT_TYPES.map do |script_type|
            script_path.join(script_type.gsub(' ', '_'), '*')
          end
        end

        def origin_set?
          repo_remote?('origin')
        end

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
            ::FileUtils.touch(vim_path.join(directory, '.gitkeep'))
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
          Script.get('pathogen.vim').install!(false)
          create_link(script_path.join('utility', 'pathogen.vim', 'plugin', 'pathogen.vim'),
                      vim_path.join('autoload', 'pathogen.vim'))
        end

        def create_vimpack_repo
          init_repo(pack_path)
        end

        def initialize_vimrc
          template('vimrc', self.pack_path.join('vimrc')) unless ::File.exists?(self.pack_path.join('vimrc'))
          create_link(self.pack_path.join('vimrc'), self.home_path.join('.vimrc'))
        end

      end
      setup_paths(ENV['HOME'])
    end
  end
end

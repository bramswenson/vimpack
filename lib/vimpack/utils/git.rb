module Vimpack
  module Utils
    module Git
      def create_vimpack_repo
        run_process_or_die!("git init --quiet", ".vimpack")
      end

      def add_submodule(repo_uri, path=nil, dir=nil)
        path ||= repo_uri.split('/')[-1].sub(/\.git$/, '')
        dir ||= ::File.join('.vimpack', 'vim', 'bundle')
        run_process_or_die!("git submodule add #{repo_uri} #{path}", dir)
        init_submodule('pathogen.vim', '.vimpack')
        update_submodule('pathogen.vim', '.vimpack')
      end

      def init_submodule(path, dir=nil)
        dir ||= ::File.join('.vimpack', 'vim', 'bundle')
        run_process_or_die!("git submodule init #{path}", dir)
      end

      def update_submodule(path, dir=nil)
        dir ||= ::File.join('.vimpack', 'vim', 'bundle')
        run_process_or_die!("git submodule update #{path}", dir)
      end

    end
  end
end

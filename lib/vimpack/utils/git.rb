module Vimpack
  module Utils
    module Git
      def create_vimpack_repo
        run_process_or_die!("git init", ".vimpack")
      end

      def initialize_submodule(repo_uri, path=nil, dir=nil)
        path ||= repo_uri.split('/')[-1].sub(/\.git$/, '')
        dir ||= ::File.join('.vimpack', 'vim', 'bundle')
        command = "git submodule add #{repo_uri} #{path}"
        run_process_or_die!(command, dir)
      end

    end
  end
end

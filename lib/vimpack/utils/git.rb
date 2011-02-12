module Vimpack
  module Utils
    module Git
      def create_vimpack_repo
        run_process_or_die!("git init --quiet", self.pack_path)
      end

      def add_submodule(repo_uri, name)
        path = ::File.join('scripts', name)
        run_process_or_die!("git submodule add #{repo_uri} #{path}",
                            self.pack_path)
        init_submodule(path)
        update_submodule(path)
      end

      def init_submodule(path)
        run_process_or_die!("git submodule init #{path}", self.pack_path)
      end

      def update_submodule(path)
        run_process_or_die!("git submodule update #{path}", self.pack_path)
      end

    end
  end
end

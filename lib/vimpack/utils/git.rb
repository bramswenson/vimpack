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

      def replace_contents(path, match, new='')
        contents = ::File.read(path)
        contents = contents.sub(match, new)
        ::File.open(path, 'w') do |file|
          file.write(contents)
        end
      end

      def remove_submodule(name)
        path = ::File.join('scripts', name)
        submod_match = ::Regexp.escape("[submodule \"#{path}\"]") + '\n.*\n.*'
        config_match = ::Regexp.escape("[submodule \"#{path}\"]") + '\n.*'
        replace_contents(self.pack_path.join('.gitmodules'), submod_match)
        replace_contents(self.pack_path.join('.git', 'config'), config_match)
        remove_link(self.bundle_path.join(name))
        remove_directory(self.pack_path.join(path))
        run_process_or_die!("git rm -r #{path}", self.pack_path)
      end

      def init_submodule(path='')
        run_process_or_die!("git submodule init #{path}", self.pack_path)
      end

      def update_submodule(path='')
        run_process_or_die!("git submodule update #{path}", self.pack_path)
      end

      def repo_add_remote(name, path)
        cmd = "git remote add #{name} #{path}"
        say(" * adding remote #{name}")
        run_process_or_die!(cmd, self.pack_path.to_s)
        say("remote #{name} added!")
      end

      def repo_commit(msg='')
        msg = '[VIMPACK] vimpack updated' if msg == ''
        cmd = "git add . && git commit -m '#{msg}'"
        say(' * commiting vimpack repo')
        run_process_or_die!(cmd, self.pack_path.to_s)
        say("commited: #{msg}!")
      end

      def repo_push(force=false)
        cmd = "git push origin master"
        cmd << " -f" if force
        say(' * pushing vimpack repo')
        run_process_or_die!(cmd, self.pack_path.to_s)
        say('vimpack repo pushed!')
      end

      def repo_clone(repo_url, path)
        cmd = "git clone #{repo_url} #{path}"
        run_process_or_die!(cmd)
      end

      def repo_exec(subcommand, commands)
        cmd = "git #{subcommand} #{commands}"
        say(" * running #{cmd}")
        run_process_or_die!(cmd, self.pack_path.to_s)
        say("command ran: #{cmd}")
      end

    end
  end
end

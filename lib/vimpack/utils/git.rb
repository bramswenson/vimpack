module Vimpack
  module Utils
    module Git

      include Process

      def init_repo(path, bare=false)
        run_process_or_die!("git init --quiet#{bare == true ? ' --bare' : ''}", path)
      end

      def add_submodule(repo_uri, *paths)
        parent, name = paths[0..-2], paths[-1]
        path = ::File.join('scripts', *paths)
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

      def remove_submodule(*paths)
        path = ::File.join('scripts', *paths)
        submod_match = ::Regexp.escape("[submodule \"#{path}\"]") + '\n.*\n.*'
        config_match = ::Regexp.escape("[submodule \"#{path}\"]") + '\n.*'
        replace_contents(self.pack_path.join('.gitmodules'), submod_match)
        replace_contents(self.pack_path.join('.git', 'config'), config_match)
        remove_link(self.bundle_path.join(paths[-1]))
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
        run_process_or_die!(cmd, self.pack_path.to_s)
      end

      def repo_remote?(name)
        remotes = run_process_and_wait!("git remote show #{name}", pack_path.to_s)
        !remotes.message.include?('does not appear to be a git') && remotes.message.include?(name)
      end


      def repo_commit(msg='')
        msg = '[VIMPACK] vimpack updated' if msg == ''
        cmd = "git add . && git commit -m '#{msg}'"
        run_process_or_die!(cmd, self.pack_path.to_s)
      end

      def repo_pull(remote_path='origin master')
        run_process_or_die!("git pull #{remote_path}", self.pack_path.to_s)
      end

      def repo_push
        cmd = "git push origin master"
        error_message = <<-EOE
error: local repo out of sync with remote
  use git to sync with something like this:
   vimpack git fetch && vimpack git merge origin/master
        EOE
        run_process_or_die!(cmd, self.pack_path.to_s, error_message)
      end

      def repo_clone(repo_url, path)
        cmd = "git clone #{repo_url} #{path}"
        run_process_or_die!(cmd)
      end

      def repo_add_dot
        cmd = "git add ."
        run_process_or_die!(cmd, self.pack_path.to_s)
      end

      def repo_exec(subcommand, commands)
        commands = sanitize_commands(commands)
        cmd = "git #{subcommand} #{commands}"
        run_process_or_die!(cmd, self.pack_path.to_s)
      end

      def sanitize_commands(commands)
        commands.each.inject('') do |full_command, command|
          full_command << ' ' unless full_command == ''
          full_command << (command.include?(' ') ? "'#{command}'" : command)
        end
      end

    end
  end
end

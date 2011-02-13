module Vimpack
  module Commands
    class Git < Command
      SUB_COMMANDS = %w{ remote commit push publish }

      def initialize_commands
        die!("git requires at least one argument") if @commands.size < 1
        @subcommand = @commands.shift
      end

      def run
        return git_exec unless SUB_COMMANDS.include?(@subcommand)
        send("git_#{@subcommand}".to_sym)
      end

      def git_remote
        cmd = "git remote add origin #{@commands.join(' ')}"
        say(' * adding remote origin')
        run_process_or_die!(cmd, self.pack_path.to_s)
        say('remote origin added!')
      end
      
      def git_commit
        msg = @commands.join(' ')
        msg = '[VIMPACK] vimpack updated' if msg == ''
        cmd = "git add . && git commit -m '#{msg}'"
        say(' * commiting vimpack repo')
        run_process_or_die!(cmd, self.pack_path.to_s)
        say("commited: #{msg}!")
      end

      def git_push
        cmd = "git push origin master"
        cmd << " -f" if @options[:force]
        say(' * pushing vimpack repo')
        run_process_or_die!(cmd, self.pack_path.to_s)
        say('vimpack repo pushed!')
      end

      def git_publish
        git_commit
        git_push
      end

      def git_exec
        cmd = "git #{@subcommand} #{@commands.join(' ')}"
        say(" * running #{cmd}")
        run_process_or_die!(cmd, self.pack_path.to_s)
      end

    end
  end
end


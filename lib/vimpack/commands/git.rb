module Vimpack
  module Commands
    class Git < Command
      SUB_COMMANDS = %w{ publish }

      def initialize_commands
        die!("git requires at least one argument") if @commands.size < 1
        @subcommand = @commands.shift
      end

      def run
        return git_exec unless SUB_COMMANDS.include?(@subcommand)
        send("git_#{@subcommand}".to_sym)
      end

      def git_publish
        repo_add_dot
        repo_commit(@options[:message])
        repo_push
      end

      def git_exec
        repo_exec(@subcommand, @commands)
      end

    end
  end
end


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
        repo_add_remote('origin', @commands.join(' '))
      end
      
      def git_commit
        repo_commit(@commands.join(' '))
      end

      def git_push
        repo_push(@options[:force])
      end

      def git_publish
        git_commit
        git_push
      end

      def git_exec
        repo_exec(@subcommand, @commands.join(' '))
      end

    end
  end
end


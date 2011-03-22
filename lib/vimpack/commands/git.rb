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
        say(" * publishing vimpack repo")
        Vimpack::Models::Repo.publish!(@options[:message])
        say("vimpack repo published!")
      end

      def git_exec
        say(" * running git #{@subcommand} #{@commands.join(' ')}")
        command = Vimpack::Models::Repo.git_exec(@subcommand, @commands)
        say("command complete!")
        say(command.message, :default)
      end

    end
  end
end


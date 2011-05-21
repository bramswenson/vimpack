module Vimpack
  module Commands
    class Info < Command

      def initialize_commands
        die!("info requires a single argument") unless @commands.size == 1
        @script_name = @commands[0]
      end

      def run
        begin
          script = Vimpack::Models::Script.info(@script_name)
        rescue Vimpack::Models::Script::ScriptNotFound
          return exit_with_error!('Script not found!')
        end
        say("Name: #{script.name}")
        say("Author: #{script.author}")
        say("Version: #{script.version} (#{script.version_date})")
        say("Type: #{script.type}")
        say("Description: #{script.description}")
      end

    end
  end
end


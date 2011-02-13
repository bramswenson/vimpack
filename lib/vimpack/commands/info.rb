module Vimpack
  module Commands
    class Info < Command

      def initialize_commands
        die!("info requires a single argument") unless @commands.size == 1
        @pattern = @commands[0]
      end

      def run
        script = ::Vimpack::Api::Models::Script.info(@pattern)
        say("Name: #{script.name}")
        say("Author: #{script.author}")
        say("Version: #{script.script_version}")
        say("Type: #{script.script_type}")
        say("Description:")
        say(script.description)
      end

    end
  end
end


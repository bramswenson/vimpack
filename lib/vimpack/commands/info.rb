module Vimpack
  module Commands
    class Info < Command

      def initialize_commands
        die!("info requires a single argument") unless @commands.size == 1
        @script_name = @commands[0]
      end

      def run
        script = ::Vimpack::Api::Models::Script.info(@script_name)
        return exit_with_error!('script not found!') if script.nil?
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


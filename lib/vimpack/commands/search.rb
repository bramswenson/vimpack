module Vimpack
  module Commands
    class Search < Command

      def initialize_commands
        die!("search requires a single argument") unless @commands.size == 1
        @pattern = @commands[0]
      end

      def run
        scripts = ::Vimpack::Api::Models::Script.search(@pattern)
        linesize = scripts.sort do |a,b|
          a.name.size <=> b.name.size
        end.reverse.first.name.size + 1
        scripts.each do |script|
          say("#{script.name.ljust(linesize)} #{script.script_type}")
        end
      end

    end
  end
end


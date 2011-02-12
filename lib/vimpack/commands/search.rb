module Vimpack
  module Commands
    class Search < Command

      def initialize_commands
        die!("search requires a single argument") unless @commands.size == 1
        @pattern = @commands[0]
      end

      def run
        ::Vimpack::Api::Script.search(@pattern)
      end

    end
  end
end


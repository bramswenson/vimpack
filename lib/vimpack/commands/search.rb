module Vimpack
  module Commands
    class Search < Command

      def initialize_options
        @conditions = ::Vimpack::Api::Models::Script::SCRIPT_TYPES.map.inject(Array.new) do |conditions, script_type|
          script_type = script_type.sub(' ', '_')
          conditions << script_type if @options[script_type.to_sym]
          conditions
        end
      end

      def initialize_commands
        die!("search requires a single argument") unless @commands.size == 1
        @pattern = @commands[0]
      end

      def run
        scripts = ::Vimpack::Api::Models::Script.search(@pattern, @conditions)
        return say("no scripts found!") if scripts.empty?
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


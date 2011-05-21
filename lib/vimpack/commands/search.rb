module Vimpack
  module Commands
    class Search < Command

      def initialize_options
        @conditions = Vimpack::Models::Script::SCRIPT_TYPES.map.inject([]) do |conditions, script_type|
          conditions << script_type if @options[script_type.gsub(' ', '_').to_sym]
          conditions
        end
      end

      def initialize_commands
        die!("search requires a single argument") unless (@commands.size == 1 || !@conditions.empty?)
        @pattern = @commands[0] if @commands.size >= 1
      end

      def run
        scripts = Vimpack::Models::Script.search(@pattern, @conditions)
        return exit_with_error!('No scripts found!', 0) if scripts.empty?
        say_justified_script_names(scripts)
      end

      private

        def say_justified_script_names(scripts)
          linesize = scripts.sort do |a,b|
            a.name.size <=> b.name.size
          end.reverse.first.name.size + 1
          scripts.each do |script|
            say("#{script.name.ljust(linesize)} #{script.type}")
          end
        end

    end
  end
end


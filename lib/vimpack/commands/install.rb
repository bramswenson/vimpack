module Vimpack
  module Commands
    class Install < Command

      def initialize_commands
        die!("install requires at least one script name argument") unless @commands.size >= 0
        @script_names = @commands
      end

      def run
        @script_names.each do |script_name|
          begin
            script = ::Vimpack::Models::Script.get(script_name)
          rescue Vimpack::Models::ScriptNotFound
            possible = ::Vimpack::Models::Script.search(script_name, Array.new, 1).first rescue nil
            return possible.nil? ? 
              exit_with_error!('Script not found!') : 
              exit_with_error!("Script not found! Did you mean #{possible.name}?")
          end
          say(" * installing #{script.name}")
          script.install!
          say("#{script.name} (#{script.script_version}) installed!")
        end
      end

    end
  end
end


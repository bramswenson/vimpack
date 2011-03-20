module Vimpack
  module Commands
    class Uninstall < Command

      def initialize_commands
        die!("uninstall requires at least one script name argument") unless @commands.size >= 0
        @script_names = @commands
      end

      def run
        @script_names.each do |script_name|
          begin
            script = ::Vimpack::Models::Script.get(script_name)
            return exit_with_error!('Script not found!') unless file_exists?(script.install_path)
          rescue ::Vimpack::Models::Script::ScriptNotFound
            return exit_with_error!('Script not found!')
          end
          say(" * uninstalling #{script.name}")
          script.uninstall!
          say("#{script.name} uninstalled!")
        end
      end

    end
  end
end


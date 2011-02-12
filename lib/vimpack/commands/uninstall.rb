module Vimpack
  module Commands
    class Uninstall < Command

      def initialize_commands
        die!("uninstall requires at least one script name argument") unless @commands.size >= 0
        @scripts = @commands
      end

      def run
        @scripts.each do |script|
          uninstall_script(script)
        end
      end

    end
  end
end


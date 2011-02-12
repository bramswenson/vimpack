module Vimpack
  module Commands
    class Install < Command

      def initialize_commands
        die!("install requires at least one script name argument") unless @commands.size >= 0
        @scripts = @commands
      end

      def run
        @scripts.each do |script|
          install_script(script)
        end
      end

    end
  end
end


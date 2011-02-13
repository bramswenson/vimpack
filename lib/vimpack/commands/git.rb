module Vimpack
  module Commands
    class Git < Command

      def run
        cmd = "git #{@commands.join(' ')}"
        say(" * running #{cmd}")
        run_process_or_die!(cmd, self.pack_path.to_s)
      end

    end
  end
end


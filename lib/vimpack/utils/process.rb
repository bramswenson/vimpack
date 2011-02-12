module Vimpack
  module Utils
    module Process

      def run_process!(cmd)
        child = ::ChildProcess.build(*cmd.split(' '))
        child.start
        child
      end

      def run_process_or_die!(cmd, dir=nil)
        within_dir(dir) do 
          child = run_process!(cmd)
          until child.exited?
            sleep 0.1
          end
          die!(child.io.stderr) if child.crashed?
        end
      end

      def within_dir(dir=nil, &block)
        orig_path = Dir.pwd
        dir = dir.nil? ? orig_path : home.join(dir)
        ::Dir.chdir(dir)
        block.call
        ::Dir.chdir(orig_path)
      end

    end
  end
end

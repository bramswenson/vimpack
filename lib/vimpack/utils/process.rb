module Vimpack
  module Utils
    module Process

      def run_process!(cmd)
        child = ::ChildProcess.build(cmd)
        child.io.stdout = ::Tempfile.new('child-out')
        child.io.stderr = ::Tempfile.new('child-err')
        child.start
        child
      end

      def wait_for_child(timeout=30)
        @child.poll_for_exit(timeout.to_f)
        @child.stop unless @child.exited?
        @child.io.stdout.close
        @child.io.stderr.close
        @child.io.stdout.open
        @child.io.stderr.open
        msg = @child.io.stdout.read
        msg << " "
        msg << @child.io.stderr.read
      end

      def run_process_or_die!(cmd, dir=nil)
        @child = nil
        within_dir(dir) do 
          @child = run_process!(cmd)
        end
        msg = wait_for_child
        exit_with_error!("child process died:\n#{msg}") unless @child.exit_code == 0
      end

      def within_dir(dir=nil, &block)
        orig_path = Dir.pwd
        dir = dir.nil? ? orig_path : dir.to_s
        ::Dir.chdir(dir)
        block.call
        ::Dir.chdir(orig_path)
      end

    end
  end
end

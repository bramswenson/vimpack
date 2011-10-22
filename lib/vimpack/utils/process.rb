module Vimpack
  module Utils
    module Process
      include Io

      class Results
        attr_accessor :process, :message
        def initialize(process, message=nil)
          self.process = process
          self.message = message
        end
      end

      def run_process!(cmd)
        child = ::ChildProcess.build(cmd)
        child.io.stdout = ::Tempfile.new('child-out')
        child.io.stderr = ::Tempfile.new('child-err')
        child.start
        child
        Results.new(child)
      end

      def wait_for_child(child, timeout=240)
        child.process.poll_for_exit(timeout.to_f)
        child.process.stop unless child.process.exited?
        child.process.io.stdout.close
        child.process.io.stderr.close
        child.process.io.stdout.open
        child.process.io.stderr.open
        child.message = child.process.io.stdout.read
        child.message << " "
        child.message << child.process.io.stderr.read
        child
      end

      def run_process_and_wait!(cmd, dir=nil)
        child = nil
        within_dir(dir) do
          child = run_process!(cmd)
        end
        child = wait_for_child(child)
      end

      def run_process_or_die!(cmd, dir=nil, err_msg=nil)
        child = run_process_and_wait!(cmd, dir)
        child.message << err_msg if err_msg
        exit_with_error!("child process died:\n#{child.message}") unless child.process.exit_code == 0
        child
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

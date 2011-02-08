require 'vimpack/utils/paths'
module Vimpack
  module Utils
    def pack_path(*path)
      res = File.join(@home, *path)
      puts res.color(:red)
      res
    end

    def file_exists?(filename)
      ::File.exists?(pack_path(filename))
    end

    def directory_exists?(directory)
      ::File::directory?(pack_path(directory))
    end

    def symlink_exists?(linkname)
      ::File.exists?(linkname) && ::File.stat(linkname).symlink?
    end

    def create_link(target, linkname)
      ::FileUtils.ln_s(target, linkname)
    end

    def template_path(*path)
      ::File.join(File.dirname(__FILE__), '..', '..', 'templates', *path)
    end

    def template(name, path)
      name = name + '.erb'
      contents = ::ERB.new(File.read(template_path(name))).result(binding)
      target = File.open(path, 'w')
      target.write(contents)
      target.close
    end

    def say(message, color=:green)
      puts message.color(color) unless message.nil?
    end

    def scream(message)
      puts message.red unless message.nil?
    end

    def die!(message=nil)
      scream(message)
      return Trollop::die USAGE
    end

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
        die!(child.stderr) if child.crashed?
      end
    end

    def cd(dir)
      Dir.chdir(dir)
    end

    def within_dir(dir=nil, &block)
      orig_path = Dir.pwd
      dir = orig_path if dir.nil?
      cd(dir)
      block.call
      cd(orig_path)
    end

  end
end

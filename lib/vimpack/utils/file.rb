module Vimpack
  module Utils

    module File
      def home
        @_home ||= FilePath.new(ENV['HOME'])
        @_home
      end

      def home=(home)
        @_home = FilePath.new(home)
        @_home
      end

      def file_exists?(filename)
        ::File.exists?(home.join(filename))
      end

      def directory_exists?(directory)
        ::File::directory?(home.join(directory))
      end

      def symlink_exists?(linkname)
        ::File.exists?(home.join(linkname)) && ::File.stat(home.join(linkname)).symlink?
      end

      def create_link(target, linkname)
        ::FileUtils.ln_s(home.join(target), home.join(linkname))
      end

      def move_path(source, target)
        ::FileUtils.mv(home.join(source), home.join(target)) if file_exists?(source)
      end

      def make_dir(*paths)
        ::FileUtils.mkdir_p(home.join(*paths))
      end

      def template_path(*path)
        Vimpack.root.join('templates', *path)
      end

      def template(name, path)
        name = name + '.erb'
        contents = ::ERB.new(::File.read(template_path(name))).result(binding)
        target = ::File.open(home.join(path), 'w')
        target.write(contents)
        target.close
      end

    end
  end
end

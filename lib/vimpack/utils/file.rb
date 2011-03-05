module Vimpack
  module Utils

    module File

      attr_accessor :home_path, :pack_path, :script_path, :vim_path, :bundle_path

      def setup_paths(home_path)
        self.home_path   = FilePath.new(home_path)
        self.pack_path   = FilePath.new(self.home_path.join('.vimpack'))
        self.script_path = FilePath.new(self.pack_path.join('scripts'))
        self.vim_path    = FilePath.new(self.pack_path.join('vim'))
        self.bundle_path = FilePath.new(self.vim_path.join('bundle'))
      end

      def file_exists?(filename)
        ::File.exists?(filename)
      end

      def directory_exists?(directory)
        ::File::directory?(directory)
      end

      def symlink_exists?(linkname)
        ::File.exists?(linkname) && ::File.stat(linkname).symlink?
      end

      def create_link(target, linkname, relative=true)
        target = Pathname.new(target).relative_path_from(
          Pathname.new(::File.dirname(linkname))
        ) if relative
        ::FileUtils.ln_s(target, linkname)
      end

      def remove_link(link)
        ::FileUtils.rm(link)
      end

      def remove_directory(directory)
        exit_with_error!("no way!") if directory == '/'
        ::FileUtils.rmtree(directory)
      end

      def move_path(source, target)
        ::FileUtils.mv(source, target) if file_exists?(source)
      end

      def make_dir(*paths)
        ::FileUtils.mkdir_p(*paths)
      end

      def template_path(*path)
        Vimpack.root.join('templates', *path)
      end

      def template(name, path)
        name = name + '.erb'
        contents = ::ERB.new(::File.read(template_path(name))).result(binding)
        target = ::File.open(path, 'w')
        target.write(contents)
        target.close
      end

    end
  end
end

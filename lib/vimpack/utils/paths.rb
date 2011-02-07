module Vimpack
  module Utils
    module Paths
      def home_path
        @home_path ||= ENV['HOME']
      end

      def home_path=(path)
        @home_path = path
      end

      def vimpack_path
        File.join(home_path, '.vimpack')
      end

      def vim_path
        File.join(vimpack_path, 'vim')
      end

      def bundle_path
        File.join(vim_path, 'bundle')
      end

      def autoload_path
        File.join(vim_path, 'bundle')
      end
      def vimrc_path
        File.join(vimpack_path, 'vimrc')
      end

      def vimpack_dir_exists?
        File::directory?(vimpack_dir)
      end

      def vim_dir_exists?
        File::directory?(vim_dir)
      end

      def vimrc_file_exists?
        File.exists?(vimrc_file)
      end
    end
  end
end

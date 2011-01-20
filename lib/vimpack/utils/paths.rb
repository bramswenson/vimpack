module Vimpack
  module Utils
    module Paths
      def home_dir
        @home_dir ||= ENV['HOME']
      end

      def home_dir=(path)
        @home_dir = path
      end

      def vimpack_dir
        File.join(home_dir, '.vimpack')
      end

      def bundle_dir
        File.join(home_dir, '.vimpack')
      end

      def vim_dir
        File.join(home_dir, '.vim')
      end

      def vimrc_file
        File.join(home_dir, '.vimrc')
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

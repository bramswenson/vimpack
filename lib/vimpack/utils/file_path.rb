module Vimpack
  module Utils

    class FilePath
      attr_accessor :base_path
      def initialize(base_path)
        self.base_path = base_path
      end

      def base_path=(base_path)
        @base_path = ::File.expand_path(base_path)
      end
      
      def join(*paths)
        ::File.join(@base_path, *paths)
      end

      def to_s
        @base_path
      end

    end

  end
end

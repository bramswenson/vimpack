require 'vimpack/utils/file'
require 'vimpack/utils/io'
require 'vimpack/utils/git'
require 'vimpack/utils/process'

module Vimpack
  module Commands
    class Command
      include ::Vimpack::Utils::File
      include ::Vimpack::Utils::Io
      include ::Vimpack::Utils::Git
      include ::Vimpack::Utils::Process

      def initialize(args, options)
        @commands = args
        @options = options
        setup_paths(@options[:home_directory] || ENV['HOME'])
        initialize_options
        initialize_commands
      end

      def initialize_options
      end

      def initialize_commands
      end

      def run
        raise NotImplemented
      end

      def self.run(args, options)
        new(args, options).run
      end

    end
  end
end

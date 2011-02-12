module Vimpack
  module Commands
    class Command
      include ::Vimpack::Utils
      def initialize(options, commands)
        @options = options
        @commands = commands
        self.home = FilePath.new(@options[:home_directory] || ENV['HOME'])
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

      def self.run(options = Hash.new, commands)
        new(options, commands).run
      end

    end
  end
end

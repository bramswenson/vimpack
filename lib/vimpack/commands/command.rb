module Vimpack
  module Commands
    class Command
      include ::Vimpack::Utils::File
      include ::Vimpack::Utils::Io
      include ::Vimpack::Utils::Git
      include ::Vimpack::Utils::Process

      def initialize(options, global_options)
        @options = options
        @global_options = global_options
        @commands = ARGV
        setup_paths(@options[:home_directory] || ENV['HOME'])
        initialize_environment
        initialize_global_options
        initialize_options
        initialize_commands
      end

      def initialize_environment
        Vimpack.environment = @global_options[:environment].to_sym
        unless Vimpack.env?('production')
          say(" * using environment #{Vimpack.environment.inspect}")
        end
      end

      def initialize_global_options
      end

      def initialize_options
      end

      def initialize_commands
      end

      def run
        raise NotImplemented
      end

      def self.run(options = Hash.new, commands = Hash.new)
        new(options, commands).run
      end

    end
  end
end

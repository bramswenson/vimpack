module Vimpack
  module Commands
    class Command
      include ::Vimpack::Utils
      def initialize(options)
        @options = options.merge(:home_directory => ENV['HOME'])
        home = @options[:home_directory]
      end

      def run
        raise NotImplemented
      end

      def self.run(options = Hash.new)
        new(options).run
      end

    end
  end
end

require 'vimpack/commands/init'
require 'vimpack/commands/search'

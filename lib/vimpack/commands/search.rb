module Vimpack
  module Commands
    class Search
      def initialize(app, pattern, home_dir=nil)
        @app = app
        @app.destination_root = home_dir || ENV['HOME']
        @pattern = pattern
      end

      def run
      end

      def self.run(app, pattern)
        Search.new(app, pattern).run
      end

    end
  end
end


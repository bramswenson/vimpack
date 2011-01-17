module Vimpack
  module Commands
    class Init
      def initialize(app)
        @app = app
      end

      def run
        @app.say('vimpack initialized!', :green) 
      end
      def self.run(app)
        Init.new(app).run
      end
    end
  end
end

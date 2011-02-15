module Vimpack
  module Utils
    module Io

      def say(message, color=:green)
        puts message.color(color) unless message.nil?
      end

      def scream(message)
        say(message, :red)
      end

      def die!(message=nil)
        scream(message)
        return Trollop::die USAGE
      end

      def exit_with_error!(message=nil, exit_code=1)
        scream(message) unless message.nil?
        exit(exit_code)
      end

    end
  end
end


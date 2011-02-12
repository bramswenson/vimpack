module Vimpack
  module Utils
    module Io

      def say(message, color=:green)
        puts message.color(color) unless message.nil?
      end

      def scream(message)
        puts message.red unless message.nil?
      end

      def die!(message=nil)
        scream(message)
        return Trollop::die USAGE
      end

    end
  end
end


module Vimpack
  module Models

    class Base
      class << self

        include ::Vimpack::Utils::File
        include ::Vimpack::Utils::Git

        attr_reader :attributes
        def attributes(*attribute_names)
          return @attributes if attribute_names.empty?
          attribute_names = attribute_names.map(&:to_sym)
          @attributes = attribute_names
          attr_accessor *attribute_names
        end

      end
      setup_paths(ENV['HOME'])

      def initialize(attributes = Hash.new)
        attributes.each do |name, value|
          send("#{name}=".to_sym, value)
        end
      end

    end
  end
end

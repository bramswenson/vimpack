module Vimpack
  module Models

    class Base
      include ActiveModel::Serializers::JSON
      class << self

        include ::Vimpack::Utils::File
        include ::Vimpack::Utils::Git
        include ::Vimpack::Utils::Scripts

        def json_parser
          @json_parser = Yajl::Parser.new
        end

        def from_json(json_data)
          new(json_parser.parse(json_data))
        end

      end
      setup_paths(ENV['HOME'])

      attr_accessor :attributes
      def initialize(attributes = Hash.new)
        self.attributes = attributes
        self.attributes.each do |name, value|
          send("#{name}=".to_sym, value)
        end
      end


    end
  end
end

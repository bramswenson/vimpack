module Vimpack
  module Models

    class Base
      include ActiveModel::Serializers::JSON

      attr_accessor :attributes
      def initialize(attributes = Hash.new)
        self.attributes = attributes
        self.attributes.each do |name, value|
          send("#{name}=".to_sym, value)
        end
      end

      def self.json_parser
        @json_parser = Yajl::Parser.new
      end

      def self.from_json(json_data)
        new(json_parser.parse(json_data))
      end

    end

  end
end

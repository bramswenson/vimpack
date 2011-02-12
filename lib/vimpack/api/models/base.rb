module Vimpack
  module Api
    module Models

      class Base
        include ActiveModel::Serializers::JSON
        include ActiveModel::Validations

        def initialize(attributes = Hash.new)
          attributes.each do |name, value|  
            send("#{name}=", value)  
          end  
        end  

        def self.json_parser
          @json_parser ||= Yajl::Parser.new
        end

        def self.from_json(json_data)
          new(json_parser.parse(json_data))
        end

      end
      
    end
  end
end
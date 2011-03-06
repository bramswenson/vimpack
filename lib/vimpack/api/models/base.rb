module Vimpack
  module Api
    module Models

      class Base
        include ActiveModel::Serializers::JSON
        include ActiveModel::Validations

        class << self
          attr_accessor :base_url
        end

        def initialize(attributes = Hash.new)
          attributes.each do |name, value|
            send("#{name}=".to_sym, value)
          end
        end

        def self.json_parser
          @json_parser ||= Yajl::Parser.new
        end

        def self.from_json(json_data)
          new(json_parser.parse(json_data))
        end

        def self.base_url(url=nil)
          @base_url ||= 'http://api.vimpack.org/api/v1'
          @base_url = url.nil? ? @base_url : url
        end

        protected
        def self.setup_request_url(path)
          [ self.base_url, path ].join('/')
        end

        def self.rest_client(method, path, options=Hash.new)
          options.merge!(:content_type => :json, :accept => :json)
          begin
            RestClient.send(method.to_sym, setup_request_url(path), options)
          rescue => e
            raise e
          end
        end

      end
    end
  end
end

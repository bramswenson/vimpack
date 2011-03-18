module Vimpack
  module Utils
    module Api

      def self.included(base)
        base.send(:extend,  ClassMethods)
      end

      module ClassMethods
        attr_accessor :base_url

        def base_url(url=nil)
          @base_url ||= 'http://api.vimpack.org/api/v1'
          @base_url = url.nil? ? @base_url : url
        end

        def setup_request_url(path)
          [ base_url, path ].join('/')
        end

        def rest_client(method, path, options=Hash.new)
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

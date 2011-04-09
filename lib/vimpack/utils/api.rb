module Vimpack
  module Utils
    module Api

      def self.included(base)
        base.send(:extend,  ClassMethods)
        unless Vimpack.env?('production')
         require 'vcr'
         VCR.config do |c|
           c.cassette_library_dir     = Vimpack.root.join('cassette_library')
           c.stub_with                :webmock
           c.ignore_localhost         = true
           c.default_cassette_options = { :record => :new_episodes }
         end
        end
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
            send(:_rest_client, method.to_sym, setup_request_url(path), options)
          rescue => e
            raise e
          end
        end

        private
        def _rest_client(method, url, options)
          if Vimpack.env?(:production)
            RestClient.send(method, url, options)
          else
            VCR.use_cassette('vimpack') do
              RestClient.send(method, url, options)
            end
          end
        end
      end
    end
  end
end

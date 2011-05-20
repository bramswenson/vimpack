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

       def wrap_open(*args)
          wrap_http_call do
            open(*args)
          end
        end

        def wrap_http_call(cassette_name='vimpack')
          raise StandardError.new('you must give a block to wrap_http_call') unless block_given?
          if Vimpack.env?(:production)
            yield
          else
            VCR.use_cassette(cassette_name) do
              yield
            end
          end
        end
      end
    end
  end
end

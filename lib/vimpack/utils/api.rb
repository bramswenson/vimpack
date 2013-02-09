require 'open-uri'

module Vimpack
  module Utils
    module Api

      def self.included(base)
        base.send(:extend,  ClassMethods)
      end

      module ClassMethods

        def wrap_open(*args)
          open(*args)
        end

        def wrap_http_call(cassette_name='vimpack')
          yield
        end
      end
    end
  end
end

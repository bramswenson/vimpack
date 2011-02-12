module Vimpack
  module Api
    module Models

      class Script < Base

        attr_accessor :name, :script_type, :summary, :repo_url, :script_version
          
        def self.search(pattern)
          scripts = RestClient.get "http://api.vimpack.org/api/v1/scripts/search/#{pattern}"
          scripts = Script.json_parser.parse(scripts)
          scripts = scripts.map do |script|
            Script.new(script)
          end
        end

      end

    end
  end
end

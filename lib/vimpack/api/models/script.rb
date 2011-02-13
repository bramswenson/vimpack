module Vimpack
  module Api
    module Models

      class Script < Base

        attr_accessor :name, :script_type, :summary, :repo_url, :script_version, :description, :author
          
        def self.search(pattern)
          scripts = RestClient.get "http://api.vimpack.org/api/v1/scripts/search/#{pattern}"
          scripts = Script.json_parser.parse(scripts)
          scripts = scripts.map do |script|
            Script.new(script)
          end
        end

        def self.get(script_name)
          script = RestClient.get "http://api.vimpack.org/api/v1/scripts/#{script_name}"
          script = Script.from_json(script)
          script
        end

        def self.info(script_name)
          script = RestClient.get "http://api.vimpack.org/api/v1/scripts/#{script_name}/info"
          script = Script.from_json(script)
          script
        end


      end
    end
  end
end

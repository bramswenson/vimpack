module Vimpack
  module Api
    module Models

      class Script < Base
        base_url 'http://api.vimpack.org/api/v1/scripts'
        attr_accessor :name, :script_type, :summary, :repo_url, :script_version,
                      :description, :author

        SCRIPT_TYPES = [ 'utility', 'color scheme', 'syntax', 'ftplugin', 
                         'indent', 'game', 'plugin', 'patch' ]

        def self.search(pattern, conditions=Array.new)
          unless conditions.empty?
            scripts = self.rest_client(:get, "search/#{pattern}", 
                                       { :params => { :script_type => conditions.join(',') } })
          else
            scripts = self.rest_client(:get, "search/#{pattern}")
          end
          scripts = Script.json_parser.parse(scripts)
          scripts = scripts.map do |script|
            Script.new(script)
          end
        end

        def self.get(script_name)
          begin
            script = self.rest_client(:get, script_name)
          rescue RestClient::InternalServerError
            # script not found
            return nil
          end
          script = Script.from_json(script)
          script
        end

        def self.info(script_name)
          begin
            script = self.rest_client(:get, "#{script_name}/info")
          rescue RestClient::InternalServerError
            # script not found
            return nil
          end
          script = Script.from_json(script)
          script
        end
        
      end
    end
  end
end

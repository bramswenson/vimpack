module Vimpack
  module Models

    class Script < Base
      base_url 'http://api.vimpack.org/api/v1/scripts'
      attr_accessor :name, :script_type, :summary, :repo_url, :script_version,
                    :description, :author

      SCRIPT_TYPES = [ 'utility', 'color scheme', 'syntax', 'ftplugin',
                       'indent', 'game', 'plugin', 'patch' ]

      def self.search(pattern=nil, conditions=Array.new, limit=100, page=1)
        params = { :limit => limit, :page => page }
        params[:script_type] = conditions.join(',') unless conditions.empty?
        path   = pattern.nil? ? 'search' : "search/#{pattern}"
        begin
          scripts = self.rest_client(:get, path, :params => params)
        rescue RestClient::InternalServerError
          return []
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

      def install!
      end

      def uninstall!
      end

      def installed?
      end

    end
  end
end

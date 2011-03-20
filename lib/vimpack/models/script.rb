module Vimpack
  module Models

    class Script < ApiBase
      class ScriptNotFound < StandardError; end
      class AlreadyInstalled < StandardError; end
      class NotInstalled < StandardError; end

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
          raise ScriptNotFound.new(script_name)
        end
        script = Script.from_json(script)
        script
      end

      def self.info(script_name)
        begin
          script = self.rest_client(:get, "#{script_name}/info")
        rescue RestClient::InternalServerError
          raise ScriptNotFound.new(script_name)
        end
        script = Script.from_json(script)
        script
      end

      def install!(link_to_bundle=true)
        Repo.raise_unless_initialized!
        raise AlreadyInstalled.new(name) if installed?
        Repo.add_submodule(repo_url, script_type.gsub(' ', '_'), name)
        if link_to_bundle
          Repo.create_link(install_path, bundle_path)
        end
        true
      end

      def uninstall!
        Repo.raise_unless_initialized!
        raise NotInstalled.new(name) unless installed?
        Repo.remove_submodule(script_type.gsub(' ', '_'), name)
        Repo.remove_link(bundle_path) if Repo.symlink_exists?(bundle_path)
        true
      end

      def installed?
        Repo.initialized? && Repo.directory_exists?(install_path)
      end

      def installable?
        Repo.initialized? && !installed?
      end

      def install_path
        Repo.script_path.join(script_type.gsub(' ', '_'), name)
      end

      def bundle_path
        Repo.bundle_path.join(name)
      end

      private

        def self.script_not_found(name)
          scripts = search(name, Array.new, 1)
          return exit_with_error!("Script not found! Did you mean #{scripts.first.name}?") if scripts.any?
          exit_with_error!('Script not found!')
        end

    end
  end
end

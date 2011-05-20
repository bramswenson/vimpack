module Vimpack
  module Models

    class Script
      include Vimpack::Utils::Vimscripts
      include Vimpack::Utils::Github

      class ScriptNotFound < StandardError; end
      class AlreadyInstalled < StandardError; end
      class NotInstalled < StandardError; end

      # From Vimscripts.org
      attr_accessor :name, :script_type, :summary, :version,
        :author, :author_email, :script_version
      # From Github
      attr_accessor :url, :description, :github

      SCRIPT_TYPES = [ 'utility', 'color scheme', 'syntax', 'ftplugin',
                       'indent', 'game', 'plugin', 'patch' ]

      def initialize(attrs={})
        setup_accessors(attrs)
        set_attributes_from_github
      end

      def setup_accessors(attrs)
        attrs.each_pair do |attr, value|
          self.send("#{attr}=", value)
        end
      end

      def set_attributes_from_github
        url = "vim-scripts/#{name}"
        self.github = self.class.repo("vim-scripts/#{self.name}")
        [ :url, :description ].each { |attr| send("#{attr}=", self.github[attr]) }
      end

      def self.search(q)
        search_vimscripts(q).map do |vimscript|
          Script.new(vimscript)
        end
      end

      def self.get(name)
        vimscript = get_vimscript(name)
        raise ScriptNotFound.new(name) if vimscript.nil?
        Script.new(vimscript)
      end

      def self.info(name)
        self.get(name)
      end

      def install!(link_to_bundle=true)
        Repo.raise_unless_initialized!
        raise AlreadyInstalled.new(name) if installed?
        Repo.add_submodule(url, script_type.gsub(' ', '_'), name)
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

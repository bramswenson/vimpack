module Vimpack
  module Models

    class Script
      include Vimpack::Utils::Vimscripts
      include Vimpack::Utils::Github

      class ScriptNotFound < StandardError; end
      class AlreadyInstalled < StandardError; end
      class NotInstalled < StandardError; end

      # From Vimscripts.org
      attr_reader :name, :type, :version, :version_date, :author, :author_email
      # From Github
      attr_reader :url, :description

      SCRIPT_TYPES = [ 'utility', 'color scheme', 'syntax', 'ftplugin',
                       'indent', 'game', 'plugin', 'patch' ]

      def initialize(attrs={})
        set_attributes_from_input(attrs)
        set_attributes_from_github
      end

      def set_attributes_from_input(attrs)
        attrs.each_pair do |attr, value|
          instance_variable_set("@#{attr}".to_sym, value)
        end
      end

      def set_attributes_from_github
        url = "vim-scripts/#{name}"
        @repo = self.class.repo("vim-scripts/#{name}")
        [ :url, :description ].each { |attr| instance_variable_set("@#{attr}".to_sym, @repo[attr]) }
        set_version_from_github
      end

      def commits
        @commits ||= self.class.commits(@repo).sort do |a, b|
          a.authored_date <=> b.authored_date
        end
      end

      def set_version_from_github
        last_commit = commits.last
        @version = last_commit.message[0..10].gsub(/Version /, '')
        @version_date = last_commit.authored_date
      end

      def self.search(q, types = [], limit = 10, offset = 0)
        search_vimscripts(q, types).map do |vimscript|
          Script.new(vimscript)
        end
      end

      def self.get(name)
        vimscript = get_vimscript(name)
        raise ScriptNotFound.new(name) if vimscript.nil?
        Script.new(vimscript)
      end

      def self.info(name)
        get(name)
      end

      def install!(link_to_bundle=true)
        Repo.raise_unless_initialized!
        raise AlreadyInstalled.new(name) if installed?
        Repo.add_submodule(url, type.gsub(' ', '_'), name)
        if link_to_bundle
          Repo.create_link(install_path, bundle_path)
        end
        true
      end

      def uninstall!
        Repo.raise_unless_initialized!
        raise NotInstalled.new(name) unless installed?
        Repo.remove_submodule(type.gsub(' ', '_'), name)
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
        Repo.script_path.join(type.gsub(' ', '_'), name)
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

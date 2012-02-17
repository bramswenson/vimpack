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
      # From awesomeness
      attr_reader :repo_owner

      SCRIPT_TYPES = [ 'utility', 'color scheme', 'syntax', 'ftplugin',
                       'indent', 'game', 'plugin', 'patch', 'github' ]

      def initialize(attrs={})
        set_attributes_from_input(attrs)
        set_attributes_from_github
      end

      def set_attributes_from_input(attrs)
        attrs.each_pair do |attr, value|
          instance_variable_set("@#{attr}".to_sym, value)
        end
      end

      def github_short_url
        @github_short_url ||= "#{repo_owner}/#{name}"
      end

      def set_attributes_from_github
        @repo = self.class.repo(github_short_url)
        instance_variable_set("@description".to_sym, @repo[:description])
        instance_variable_set("@url".to_sym, @repo[:clone_url])
        set_version_from_github
      end

      def commits
        @commits ||= self.class.commits(github_short_url).sort do |a, b|
          a.authored_date <=> b.authored_date
        end
      end

      def set_version_from_github
        last_commit = commits.first
        if type == 'github'
          @version = last_commit.sha
        else
          @version = last_commit.commit.message.split(':')[0][0..10].gsub(/Version /, '')
        end
        @version_date = last_commit.commit.author.date
      end

      def self.search(q, types = [], limit = 10, offset = 0)
        search_vimscripts(q, types).map do |vimscript|
          Script.new(vimscript)
        end
      end

      def self.get(name)
        # If the name has a slash in it, then it's URLy and it's a straight github repo
        _type = name.include?('/') ? :github : :vimscript
        case _type
        when :github
          repo_key = name.split("/")[-2..-1].join("/").split(".").first # wut demeter?
          repo = repository(repo_key)
          script_hash =
            { :name => repo.name, :type => 'github',
              :description => repo.description, :script_version => '',
              :author => repo.owner.login, :author_email => '',
              :repo_owner => repo.owner.login
            }
        when :vimscript
          script_hash = get_vimscript(name)
          raise ScriptNotFound.new(name) if script_hash.nil?
        end
        Script.new(script_hash)
      end

      def self.info(name)
        get(name)
      end

      def install!(link_to_bundle=true)
        Repo.raise_unless_initialized!
        raise AlreadyInstalled.new(name) if installed?
        case type
        when 'github'
          Repo.add_submodule(url, type.gsub(' ', '_'), repo_owner, name)
        else
          Repo.add_submodule(url, type.gsub(' ', '_'), name)
        end
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
        case type
        when 'github'
          Repo.script_path.join(type.gsub(' ', '_'), repo_owner, name)
        else
          Repo.script_path.join(type.gsub(' ', '_'), name)
        end
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

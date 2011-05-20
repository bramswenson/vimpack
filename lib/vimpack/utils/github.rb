module Vimpack
  module Utils
    module Github

      def self.included(base)
        base.send(:include, Vimpack::Utils::Api)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods

        def octokit
          @octokit ||= Octokit::Client.new
        end

        def search_all_repos(q, options = {})
          search_repositories(CGI.escape(q), options.merge(:language => 'VimL')).delete_if do |repo|
            repo.name.downcase.include?('dotfiles') ||
              repo.description.downcase.include?('dotfiles')
          end
        end

        def search_vimscript_repos(q)
          search_all_repos(q).delete_if { |repo| !(repo.owner == 'vim-scripts') }
        end

        def respond_to?(meth)
          octokit.respond_to?(meth) || super
        end

        def method_missing(meth, *args)
          if octokit.respond_to?(meth)
            return wrap_http_call { octokit.send(meth, *args) }
          end
          super
        end

      end
    end
  end
end
